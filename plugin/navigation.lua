vim.pack.add({
  { src = "https://github.com/ibhagwan/fzf-lua" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/LintaoAmons/cd-project.nvim" },
})

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

vim.keymap.set("n", "-", vim.cmd.Oil)
-- Oil as a (kinda janky) sidebar, <leader><CR> temporarily set to enter the
-- file and :only it
vim.keymap.set("n", "<leader>-", function()
  vim.cmd([[
    " Maybe there's a nicer way of doing this?
    vsplit
    vertical resize 30
    Oil
  ]])
  -- Create a temporary keymap where when we enter the file, we remove the
  -- <leader><CR> keymap!
  vim.keymap.set("n", "<leader><CR>", function()
    vim.keymap.del("n", "<leader><CR>")
    vim.api.nvim_input("<cr>")
    vim.cmd("only")
  end)
end)

-- CDProject
require("cd-project").setup({
  format_json = true,
  project_dir_pattern = { ".git", ".gitignore", "package.json", "go.mod" },
  projects_config_filepath = vim.fs.normalize(vim.fn.stdpath("config") .. "/projects.json"),
  projects_picker = "fzf-lua",
  hooks = {
    {
      callback = function(dir)
        vim.notify("switched to dir: " .. dir)
      end,
    },
    {
      callback = function(_)
        vim.cmd("Oil")
      end,
    },
    {
      callback = function(_)
        require("fzf-lua").files()
      end,
    },
  },
  auto_register_project = true,
})
vim.keymap.set("n", "<leader>cd", vim.cmd.CdProject)

local f = require("fzf-lua")
f.setup({
  -- Ivy-style layout
  winopts = {
    width = 1.0,
    height = 0.45,
    row = 1.0,
    col = 0.5,
    border = "none",
    preview = {
      hidden = "nohidden",
      layout = "horizontal",
      flip_columns = 160,
    },
  },
  keymap = {
    fzf = {
      -- Use <c-q> to select all items and add them to the quickfix list
      true,
      ["ctrl-q"] = "select-all+accept",
    },
  },
})
vim.keymap.set("n", "<leader><leader>", function()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  if #bufs > 2 then
    f.buffers()
  else
    vim.cmd.bnext()
  end
end)
vim.keymap.set("n", "<leader>ff", function()
  f.files()
end)
vim.keymap.set("n", "<leader>fg", function()
  f.live_grep()
end)
