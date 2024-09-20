local M = {
  -- config.lsp
  "neovim/nvim-lspconfig",
  dependencies = {
    "HiPhish/jinja.vim",
    {
      "williamboman/mason.nvim",
      config = true,
      lazy = false,
      priority = 1000,
    },
    "williamboman/mason-lspconfig.nvim",
    "b0o/SchemaStore.nvim",
    "jubnzv/virtual-types.nvim",
    {
      "towolf/vim-helm",
      ft = "helm",
    },

    -- config.cmp
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "L3MON4D3/LuaSnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "lukas-reineke/cmp-rg",
        "nvim-orgmode/orgmode",
        "rafamadriz/friendly-snippets",
        "saadparwaiz1/cmp_luasnip",
      },
    },

    -- config.fmt
    {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      dependencies = {
        "williamboman/mason.nvim",
        "stevearc/conform.nvim",
        -- config.lint
        "mfussenegger/nvim-lint",
      },
      config = function()
        require("mason-tool-installer").setup({
          ensure_installed = {
            -- formatters
            "black",
            "jq",
            "jsonnetfmt",
            "prettier",
            "shfmt",
            "stylua",
            "yamlfix",
            -- linters
            "hadolint",
            "ansible-lint",
            "phpstan",
          },
        })
      end,
    },
  },
}

M.config = function()
  require("config.lsp").setup()
  require("config.cmp").setup()
  require("config.fmt").setup()
  require("config.lint").setup()
end

return M
