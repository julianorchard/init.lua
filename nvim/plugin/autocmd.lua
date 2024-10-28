local function setup_autocmd()
  -- Remove blank line endings on save
  vim.api.nvim_create_autocmd("BufWritePre", {
    -- group = vim.api.nvim_create_augroup("return-cursor", { clear = false }),
    desc = "Return the cursor to the previous position in the file",
    command = [[ :%s/\s\+$//ge ]],
  })

  -- Return-cursor
  vim.api.nvim_create_autocmd("BufReadPost", {
    group = vim.api.nvim_create_augroup("return-cursor", { clear = true }),
    desc = "Return the cursor to the previous position in the file",
    command = [[ if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]],
  })

  -- Terminal
  vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("terminal", { clear = true }),
    desc = "Hook into terminal opening",
    command = [[
      :startinsert
      :setlocal nonumber norelativenumber
    ]],
  })

  -- Stolen from @mfussenegger (GitHub) dotfiles
  -- if helpers_available then
  vim.api.nvim_create_autocmd("BufNewFile", {
    group = vim.api.nvim_create_augroup("templates", { clear = true }),
    desc = "Load template file",
    callback = function(args)
      local home = os.getenv("HOME")
      local fname = vim.fn.fnamemodify(args.file, ":t")
      local tmpl = home .. "/.config/nvim/templates/" .. fname .. ".tpl"
      if vim.loop.fs_stat(tmpl) then
        vim.cmd("0r " .. tmpl)
      else
        local ext = vim.fn.fnamemodify(args.file, ":e")
        tmpl = home .. "/.config/nvim/templates/" .. ext .. ".tpl"
        if vim.loop.fs_stat(tmpl) then
          vim.cmd("0r " .. tmpl)
        end
      end
    end,
  })
  -- end

  -- @dfsully (Reddit) - this works incredibly with the above
  -- https://www.reddit.com/r/neovim/comments/16wvklu/comment/k306c5c/
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("executable", { clear = true }),
    desc = "Mark script files with shebangs as executable on write",
    callback = function()
      local shebang = vim.api.nvim_buf_get_lines(0, 0, 1, true)[1]
      if not shebang or not shebang:match("^#!.+") then
        return
      end
      vim.api.nvim_create_autocmd("BufWritePost", {
        once = true,
        callback = function(args)
          local filename = vim.api.nvim_buf_get_name(args.buf)
          local fileinfo = vim.uv.fs_stat(filename)
          if not fileinfo or bit.band(fileinfo.mode - 32768, 0x40) ~= 0 then
            return
          end
          vim.uv.fs_chmod(filename, bit.bor(fileinfo.mode, 493))
        end,
      })
    end,
  })

  vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    group = vim.api.nvim_create_augroup("tfstate-to-json", { clear = true }),
    desc = "Recognise .tfstate files JSON",
    pattern = { "*.tfstate" },
    command = [[ :set filetype=json]],
  })

  -- Highlight on yank (very cool)
  local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
  vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
      vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
  })
end

setup_autocmd()
