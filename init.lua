vim.loader.enable()
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.pack.add({
  {
    src = "https://github.com/j-hui/fidget.nvim",
    version = "v1.5.0",
  },
  {
    src = "https://github.com/nullromo/go-up.nvim",
  },
  {
    src = "https://github.com/fei6409/log-highlight.nvim",
  },
  {
    src = "https://github.com/vague2k/vague.nvim",
  },
  {
    src = "https://github.com/folke/snacks.nvim",
  },

  -- Nav
  {
    src = "https://github.com/ibhagwan/fzf-lua",
  },
  {
    src = "https://github.com/stevearc/oil.nvim",
  },
  {
    src = "https://github.com/LintaoAmons/cd-project.nvim",
  },
  {
    src = "https://github.com/christoomey/vim-tmux-navigator",
  },

  -- LSP
  {
    src = "https://github.com/mason-org/mason.nvim",
  },
  {
    src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  {
    src = "https://github.com/stevearc/conform.nvim",
  },

  {
    src = "https://github.com/b0o/SchemaStore.nvim",
  },

  -- {
  --   src = "https://github.com/TheLeoP/powershell.nvim",
  -- },

  "https://github.com/rafamadriz/friendly-snippets",
  "https://github.com/moyiz/blink-emoji.nvim",
  "https://github.com/mikavilpas/blink-ripgrep.nvim",
  "https://github.com/L3MON4D3/LuaSnip",
  {
    src = "https://github.com/Saghen/blink.cmp",
    version = vim.version.range("^1"),
  },

  {
    src = "https://github.com/lewis6991/gitsigns.nvim",
  },

  -- Editor
  {
    src = "https://github.com/chaoren/vim-wordmotion",
  },

  {
    src = "https://github.com/mg979/vim-visual-multi",
  },

  {
    src = "https://github.com/tpope/vim-surround",
  },

  {
    src = "https://github.com/tpope/vim-fugitive",
  },

  {
    src = "https://github.com/mbbill/undotree",
  },

  {
    src = "https://github.com/junegunn/vim-easy-align",
  },
})

-- Fidget
require("config.fidget").setup()

-- -- Snacks
-- -- NOTE: Why doesn't this work?
if not package.loaded["snacks"] then
  require("snacks").setup({
    -- Input QOL (my main reason for wanting this)
    input = { enabled = true },
    -- File related QOLs
    bigfile = { enabled = true },
    quickfile = { enabled = true },
  })
end

require("go-up").setup()

require("vague").setup({
  transparent = true,
})
vim.cmd.colorscheme("vague")

require("mason").setup()
require("mason-tool-installer").setup({
  ensure_installed = {
    "lua-language-server",
    "stylua",
  },
})

-- Reads all the files in the ~/.config/nvim/lsp directory to retrieve names for
-- vim.lsp.enable!
vim.lsp.enable(vim.tbl_map(function(f)
  return f:gsub("%.lua$", "")
end, vim.fn.readdir(vim.fn.stdpath("config") .. "/lsp")))
-- TODO: PowershellLSP
-- require("powershell").setup({
--   bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
-- })

local signs = {
  Error = "失",
  Hint = "託",
  Info = "承",
  Warn = "儆",
}
vim.diagnostic.config({
  update_in_insert = false,
  virtual_text = {
    prefix = "*",
    spacing = 2,
  },
  severity_sort = true,
  float = {
    border = "square",
    source = "if_many",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = signs.Error,
      [vim.diagnostic.severity.WARN] = signs.Warn,
      [vim.diagnostic.severity.INFO] = signs.Info,
      [vim.diagnostic.severity.HINT] = signs.Hint,
    },
  },
})

vim.keymap.set({ "n" }, "<leader><F5>", vim.cmd.UndotreeToggle)

vim.g.easy_align_ignore_groups = { "String" }
vim.keymap.set({ "v", "x" }, "<leader>aa", "<cmd>'<,'>EasyAlign<cr>")
vim.keymap.set({ "v", "x" }, "<leader>a|", "<cmd>'<,'>EasyAlign<cr>")

-- Completion
require("luasnip.loaders.from_vscode").lazy_load({
  paths = vim.fn.stdpath("config") .. "/snippets",
})
require("blink.cmp").setup({
  keymap = {
    ["<c-k>"] = { "select_prev", "fallback" },
    ["<up>"] = { "select_prev", "fallback" },
    ["<c-j>"] = { "select_next", "fallback" },
    ["<down>"] = { "select_next", "fallback" },
    ["<cr>"] = {
      "snippet_forward",
      "accept",
      "fallback",
    },
  },
  appearance = {
    nerd_font_variant = "mono",
  },
  completion = {
    documentation = {
      auto_show = true,
    },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer", "ripgrep", "emoji" },
    providers = {
      ripgrep = {
        module = "blink-ripgrep",
        name = "Ripgrep",
        opts = {},
      },
      emoji = {
        module = "blink-emoji",
        name = "Emoji",
        score_offset = 0,
        opts = {
          insert = true,
        },
      },
    },
  },
  fuzzy = {
    implementation = "prefer_rust_with_warning",
  },
})

local c = require("conform")
c.setup({
  formatters_by_ft = {
    bash = { "shfmt" },
    json = { "jq" },
    jsonnet = { "jsonnetfmt" },
    lua = { "stylua" },
    python = { "black" },
    sh = { "shfmt" },
    terraform = { "terraform_fmt" },
    typescript = { "prettier" },
    yaml = { "yamlfix" },
  },

  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return nil
    end
    return { timeout_ms = 500, lsp_fallback = true }
  end,
})

c.formatters.shfmt = {
  prepend_args = { "-i", "4" },
}

c.formatters.yamlfix = {
  env = {
    YAMLFIX_WHITELINES = "1",
    YAMLFIX_COMMENTS_WHITELINES = "1",
    YAMLFIX_LINE_LENGTH = "200",
  },
}

c.formatters.jsonnetfmt = {
  prepend_args = { "-n", "2" },
}

vim.keymap.set("n", "<leader>fm", function()
  if vim.g.disable_autoformat then
    vim.cmd("FormatEnable")
    vim.notify("Turning autoformatting on")
  else
    vim.cmd("FormatDisable")
    vim.notify("Turning autoformatting off")
  end
end)

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

vim.g.tmux_navigator_no_mappings = 0
vim.keymap.set("n", "<C-a>h", vim.cmd.TmuxNavigateLeft)
vim.keymap.set("n", "<C-a>j", vim.cmd.TmuxNavigateDown)
vim.keymap.set("n", "<C-a>k", vim.cmd.TmuxNavigateUp)
vim.keymap.set("n", "<C-a>l", vim.cmd.TmuxNavigateRight)

local function fugimap(a, b, c)
  local cmd = string.format([[ <cmd>Git %s<cr> ]], c)
  vim.keymap.set(a, b, cmd, {
    noremap = true,
    silent = true,
  })
end
fugimap("n", "<leader>gb", "blame")
fugimap("n", "<leader>gd", "diff")
fugimap("n", "<leader>gl", "log")
fugimap("n", "<leader>gs", "status")
fugimap("n", "<leader>ga", "add .")
fugimap("n", "<leader>gp", "push")

require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
})
