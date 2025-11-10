require("mason").setup()
local registry = require("mason-registry")
local wanted = {
  "bash-language-server",
  "black",
  "gofumpt",
  "gopls",
  "jsonnet-language-server",
  "jsonnetfmt",
  "lua-language-server",
  "prettier",
  "pyright",
  "shfmt",
  "stylua",
  "terraform-ls",
  "yamlfix",
}
for _, name in ipairs(wanted) do
  local ok, pkg = pcall(registry.get_package, name)
  if ok then
    if not pkg:is_installed() then
      pkg:install()
    end
  else
    vim.notify("Mason package not found: " .. name, vim.log.levels.WARN)
  end
end

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
    default = { "lsp", "snippets", "path", "buffer", "ripgrep", "emoji" },
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
    go = { "gofumpt" },
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

  formatters = {
    shfmt = {
      prepend_args = { "-i", "4" },
    },
    yamlfix = {
      env = {
        YAMLFIX_WHITELINES = "1",
        YAMLFIX_COMMENTS_WHITELINES = "1",
        YAMLFIX_LINE_LENGTH = "200",
      },
    },
    jsonnetfmt = {
      prepend_args = { "-n", "2" },
    },
  },
})

vim.keymap.set("n", "<leader>fm", function()
  if vim.g.disable_autoformat then
    vim.cmd("FormatEnable")
    vim.notify("Turning autoformatting on")
  else
    vim.cmd("FormatDisable")
    vim.notify("Turning autoformatting off")
  end
end)

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})
