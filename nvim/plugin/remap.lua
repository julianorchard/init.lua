local function setup_remap()
  local helpers_available, h = pcall(require, "helpers.functions")
  if not helpers_available then
    return nil
  end

  --[[
    CHAR | MODE
   ------|--------------------------
       n | Normal
       v | Visual and Select
       s | Select
       x | Visual
       o | Operator-pending
       ! | Insert and Command-line
       i | Insert
       l | ":lmap" mappings for Insert, Command-line and Lang-Arg
       c | Command-line
       t | Terminal-Job
      ca | command mode abbreviations (chat is this real??)
         | https://www.reddit.com/r/neovim/comments/145pkj0/today_on_nightly_we_now_have_a_formal_lua_api_to/
  --]]

  -- It was not real
  -- h.map("ca", "xd", "XDDD")

  -- Keep cursor in the centre when C-d'ing and C-u'ing (thanks @bertiewhite)
  h.map("n", "<C-d>", "<C-d>zz")
  h.map("n", "<C-u>", "<C-u>zz")

  -- Keymaps for better default experience
  h.map({ "n", "v" }, "<Space>", "<Nop>")

  -- Remap for dealing with word wrap
  vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", {
    expr = true,
    silent = true,
  })
  vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", {
    expr = true,
    silent = true,
  })

  -- Yank to system with 'Y'
  h.map("v", "Y", '"+y')
  h.map("v", "<leader>y", '"+yy')

  -- Don't yank on change chars
  h.map("n", "c", '"_c')
  h.map("n", "C", '"_C')
  h.map("n", "cc", '"_cc')

  -- Terminal (return to normal mode on <esc>)
  h.map("t", "<esc>", "<C-n><C-\\>")

  h.map("v", "<leader>ea", [[ <CMD>EasyAlign<CR> ]])

  -- noremap <expr> <LocalLeader>e ':e ' . expand("%:h") . '/'
  h.map("n", "<leader>ee", ":e ")

  -- Abbreviations
  vim.cmd([[
  " Signs
  let gcfg = "git config "
  iab @@ hello@julianorchard.co.uk
  iab <expr> ~g substitute(system(gcfg . 'user.name') . " <" . system(gcfg . 'user.email') . ">", '\n', '', 'g')
]])

  -- Split navigation
  h.map("n", "<C-j>", "<C-w><C-j>")
  h.map("n", "<C-k>", "<C-w><C-k>") -- I think this one's busted
  h.map("n", "<C-l>", "<C-w><C-l>")
  h.map("n", "<C-h>", "<C-w><C-h>")

  -- Source current file
  h.map("n", "<leader>x", "<cmd>.lua<CR>")
  h.map("n", "<leader><leader>x", "<cmd>source %<CR>")

  -- Insert and normal mode are slightly different here
  h.map("i", "<C-t>", "<space><esc>:lua require('helpers.function').fill()<cr>")
  h.map("n", "<C-t>", "a<space><esc>:lua require('helpers.function').fill()<cr>")

  -- Insert timestamp <C-s>
  local tstamp = vim.fn.strftime("%Y-%m-%d %H:%M")
  h.map({ "i", "n" }, "<C-s>", "<esc>:lua require('helpers.function').insert_at_point('" .. tstamp .. "')<cr>A")

  -- Oil
  require("oil").setup({
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ["q"] = "actions.close",
    },
  })
  h.map("n", "-", "<cmd>Oil<cr>")
  h.map("n", "<leader>=", "<cmd>Oil --float<cr>")
  h.map("n", "<leader><cr>", function()
    vim.cmd([[
      vsplit
      vertical resize 30
      Oil
    ]])
    vim.keymap.del("n", "<leader><cr>")
    -- This is a useful one
    vim.api.nvim_input("<cr>")
    vim.cmd("only")
  end)

  -- cd-project
  -- require("cd-project").setup({
  --   format_json = true,
  --   project_dir_pattern = { ".git", ".gitignore", "package.json", "go.mod" },
  --   projects_config_filepath = vim.fs.normalize(vim.fn.stdpath("config") .. "/projects.json"),
  --   projects_picker = "telescope",
  --   hooks = {
  --     {
  --       callback = function(dir)
  --         vim.notify("switched to dir: " .. dir)
  --       end,
  --     },
  --     {
  --       callback = function(_)
  --         vim.cmd("Oil")
  --       end,
  --     },
  --     {
  --       callback = function(_)
  --         local t = require("telescope.builtin").find_files
  --         require("config.scope").scope(t)
  --       end,
  --     },
  --   },
  --   auto_register_project = true,
  -- })
end

setup_remap()
