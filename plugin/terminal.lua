Term = {}

local filetype_cmd_run = {
  ["terraform"] = {
    "terraform plan",
    "terraform apply",
    "terraform lint",
    -- this is just a test thing really; we do this with plugins, however it was good to test out the {file} functionality
    "terraform fmt {file}",
    "./authenticate.sh",
  },
  ["go"] = "go run {file}",
}

-- FIXME: Make work
-- function Term.tmux_navigator_mapping(direction)
--   if vim.fn.exists("TmuxNavigate" .. direction) == 0 then
--     return "<C-\\><C-n><CMD>TmuxNavigate" .. direction .. "<cr>"
--     -- return string.format([[ <C-\\><C-n><CMD>TmuxNavigate%s<cr> ]], direction)
--   else
--     error("Tmux navigator isn't here right now")
--   end
-- end

function Term.close(jobid)
  if not jobid then
    return
  end
  vim.fn.jobstop(jobid)
end

function Term.open()
  vim.cmd("bel new")
  vim.cmd("resize 10")
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.buflisted = false
  vim.bo.swapfile = false
end

function Term.run_cmd(cmd)
  local term_opts = { term = true }
  if cmd == nil then
    vim.notify("Couldn't run Term.cmd_run, no 'cmd' argument provided", vim.log.levels.ERROR)
    return nil
  end

  Term.open()

  if vim.fn.terminal_debug == true then
    return vim.fn.jobstart('echo "DEBUG: Would normally execute: ' .. cmd .. '"', term_opts)
  else
    return vim.fn.jobstart(cmd, term_opts)
  end
end

function Term.file_replace(input)
  return string.gsub(input, "{file}", vim.api.nvim_buf_get_name(0))
end

function Term.run_that()
  local that = filetype_cmd_run[vim.bo.filetype]
  return function()
    if type(that) == "table" then
      vim.ui.select(that, {
        prompt = "Please select what to run:",
      }, function(choice)
        Term.run_cmd(Term.file_replace(choice))
      end)
    else
      Term.run_cmd(Term.file_replace(that))
    end
  end
end

function Term.run_this()
  local file = vim.api.nvim_buf_get_name(0)
  return function()
    Term.run_cmd(file)
  end
end

function Term.setup()
  local helpers_available, h = pcall(require, "helpers.functions")
  if not helpers_available then
    return nil
  end

  -- Inspired by how @mfussenegger does similar (but my worse version)
  local jobid = nil

  -- general mappings

  -- escape terminal mode
  h.map("t", "<C-]>", "<C-\\><C-n>") -- <esc> breaks zsh vi editing modes

  -- navigation
  h.map("t", "<C-a>h", "<C-\\><C-n><CMD>TmuxNavigateLeft<CR>")
  h.map("t", "<C-a>j", "<C-\\><C-n><CMD>TmuxNavigateDown<CR>")
  h.map("t", "<C-a>k", "<C-\\><C-n><CMD>TmuxNavigateUp<CR>")
  h.map("t", "<C-a>l", "<C-\\><C-n><CMD>TmuxNavigateRight<CR>")
  -- FIXME: Broken, ploz fix
  -- h.map("t", "<C-a>h", function()
  --   Term.tmux_navigator_mapping("Left")
  -- end)
  -- h.map("t", "<C-a>j", function()
  --   Term.tmux_navigator_mapping("Down")
  -- end)
  -- h.map("t", "<C-a>k", function()
  --   Term.tmux_navigator_mapping("Up")
  -- end)
  -- h.map("t", "<C-a>l", function()
  --   Term.tmux_navigator_mapping("Right")
  -- end)

  vim.api.nvim_create_autocmd("TermClose", {
    desc = "Terminal close https://stackoverflow.com/questions/68605360",
    group = vim.api.nvim_create_augroup("TerminalClose", { clear = true }),
    callback = function()
      vim.cmd("bdelete")
    end,
  })
  vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("TerminalOpen", { clear = true }),
    desc = "Hook into terminal opening",
    command = [[
      startinsert      " start in insert mode (see also TerminalAutoInsert augroup)
      setl nonu nornu  " disable line numbers
      setl ls=0        " disable statusline
    ]],
  })
  -- NOTE: This is for when switching back to the terminal buffer - the previous
  --       autocmd is for when the buffer is opening for the first time!
  --       They could probably be consolidated but I think this is fine...
  vim.api.nvim_create_autocmd("BufEnter", {
    desc = "Auto-start insert mode when entering terminal BUFFER",
    group = vim.api.nvim_create_augroup("TerminalAutoInsert", { clear = true }),
    pattern = "term://*",
    callback = function()
      vim.cmd([[
      startinsert " start in insert mode (see also TerminalAutoInsert augroup)
      setl ls=0   " disable statusline
    ]])
    end,
  })

  vim.keymap.set("n", "<leader>tt", function()
    Term.close(jobid)
    local run = Term.run_that()
    if run == nil then
      return
    end
    jobid = run()
  end)

  vim.keymap.set("n", "<leader>tf", function()
    Term.close(jobid)
    local run = Term.run_this()
    if run == nil then
      return
    end
    jobid = run()
  end)

  h.map("n", "<leader>tb", function()
    vim.fn.jobstart(os.getenv("SHELL"), { term = true })
  end)

  h.map("n", "<leader>ts", function()
    Term.close(jobid)
    Term.open()
    jobid = vim.fn.jobstart(os.getenv("SHELL"), { term = true })
  end)

  -- TEST
  if vim.g.terminal_auto_open then
    Term.close(jobid)
    local run = Term.run_this()
    if run == nil then
      return
    end
    jobid = run()
  end
end

Term.setup()

return Term
