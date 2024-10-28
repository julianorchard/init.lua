local actions = require("telescope.actions")
local h = require("helpers.functions")
local t = require("telescope.builtin")
local telescope = require("telescope")

local M = {}

local opts = require("telescope.themes").get_ivy({})

---Custom telescope command with get_ivy as the wrapper etc.
function M.scope(cmd)
  cmd(opts)
end

---Edited from the other (probably nicer...) way of doing it:
---https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory
function M.find_files_custom()
  local is_inside_work_tree = {}
  local cwd = vim.fn.getcwd()
  if is_inside_work_tree[cwd] == nil then
    vim.fn.system("git rev-parse --is-inside-work-tree")
    is_inside_work_tree[cwd] = vim.v.shell_error == 0
  end
  if is_inside_work_tree[cwd] then
    t.git_files(opts)
  else
    t.find_files(opts)
  end
end

---Wrapper around the default telescope buffers command
function M.buffers_custom()
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  if #bufs > 2 then
    M.scope(t.buffers)
  else
    vim.cmd.bnext()
  end
end

function M.setup()
  -- Possibly related to this:
  -- https://github.com/hrsh7th/nvim-cmp/issues/1556
  telescope.setup({ ---@diagnostic disable-line: redundant-parameter
    defaults = {
      mappings = {
        i = {
          ["<C-u>"] = false,
          ["<C-d>"] = false,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-e>"] = actions.file_edit,
        },
      },
    },
    pickers = {
      find_files = {
        hidden = true,
      },
    },
  })

  h.map("n", "<Leader>ff", M.find_files_custom)

  -- Enable telescope fzf native, if installed
  pcall(require("telescope").load_extension, "fzf")

  -- Find in buffers (<leader><leader> == buffers)
  h.map("n", "<leader><space>", M.buffers_custom)

  -- fzf in the current buffer
  h.map("n", "<leader>/", function()
    t.current_buffer_fuzzy_find(require("telescope.themes").get_ivy({
      -- winblend = 10,
      previewer = false,
    }))
  end)

  -- Other than that, I only really live_grep stuff
  h.map("n", "<leader>fg", function()
    M.scope(t.live_grep)
  end)
  h.map("n", "<leader>fd", function()
    M.scope(t.diagnostics)
  end)
  h.map("n", "<leader>fh", function()
    M.scope(t.oldfiles)
  end)

  -- Just in case I want to run these manually
  h.map("n", "<leader>fgit", function()
    M.scope(t.git_files)
  end)
  h.map("n", "<leader>files", function()
    M.scope(t.find_files)
  end)
end

M.setup()

return M
