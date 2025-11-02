local function setup_autocmd()
  -- Remove blank line endings on save
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("RemoveBlankLineEndings", { clear = true }),
    desc = "Remove blank line endings on save",
    command = [[ :%s/\s\+$//ge ]],
  })

  -- Return-cursor
  vim.api.nvim_create_autocmd("BufReadPost", {
    group = vim.api.nvim_create_augroup("ReturnCursor", { clear = true }),
    desc = "Return the cursor to the previous position in the file",
    command = [[ if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]],
  })

  -- Stolen from @mfussenegger (GitHub) dotfiles
  vim.api.nvim_create_autocmd("BufNewFile", {
    group = vim.api.nvim_create_augroup("TemplateFile", { clear = true }),
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

  -- @dfsully (Reddit) - this works incredibly with the above
  -- https://www.reddit.com/r/neovim/comments/16wvklu/comment/k306c5c/
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("MakeFilesExecutable", { clear = true }),
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

  -- Highlight on yank (very cool)
  vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
    callback = function()
      vim.highlight.on_yank()
    end,
    pattern = "*",
  })

  -- Show cursor line only in active window (stolen from @folke)
  local cursor_group = vim.api.nvim_create_augroup("CursorLine", { clear = true })
  vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
    group = cursor_group,
    callback = function()
      if vim.w.auto_cursorline then
        vim.wo.cursorline = true
        vim.wo.cursorcolumn = true
        vim.w.auto_cursorline = nil
      end
    end,
  })
  vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
    group = cursor_group,
    callback = function()
      if vim.wo.cursorline then
        vim.w.auto_cursorline = true
        vim.wo.cursorcolumn = false
        vim.wo.cursorline = false
      end
    end,
  })
end

setup_autocmd()
