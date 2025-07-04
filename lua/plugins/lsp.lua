local M = {
  -- config.lsp
  "neovim/nvim-lspconfig",
  dependencies = {
    "HiPhish/jinja.vim",
    {
      "mason-org/mason.nvim",
      version = "1.11.0",
      config = true,
      lazy = false,
      priority = 1000,
    },
    {
      "mason-org/mason-lspconfig.nvim",
      version = "1.32.0",
    },
    "b0o/SchemaStore.nvim",
    "jubnzv/virtual-types.nvim",
    {
      "towolf/vim-helm",
      ft = "helm",
    },

    {
      "TheLeoP/powershell.nvim",
      opts = {
        bundle_path = vim.fn.stdpath("data") .. "/mason/packages/powershell-editor-services",
      },
    },

    -- TODO: Split this stuff up
    {
      "saghen/blink.cmp",
      dependencies = {
        "rafamadriz/friendly-snippets",
        "moyiz/blink-emoji.nvim",
        "mikavilpas/blink-ripgrep.nvim",
        {
          "L3MON4D3/LuaSnip",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })
          end,
        },
      },
      version = "1.*",
      opts = {
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
        fuzzy = { implementation = "prefer_rust_with_warning" },
      },
      opts_extend = { "sources.default" },
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
        local install_list = {}
        if vim.g.mason_autoinstall == true then
          install_list = vim.g.dependencies
        end
        require("mason-tool-installer").setup({
          ensure_installed = install_list,
        })
      end,
    },
  },
}

M.config = function()
  require("config.lsp").setup()
  require("config.fmt").setup()
  require("config.lint").setup()
end

return M
