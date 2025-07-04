local function center_comment_any()
  -- Get the next key pressed
  local next_keypress = vim.fn.getcharstr()

  -- Include the next key as the center comment character
  vim.cmd(string.format([[:CenterComment %s]], next_keypress))
end

return {
  {
    "chaoren/vim-wordmotion",
    event = "VeryLazy",
  },

  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
  },

  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },

  {
    "julianorchard/center-comment.vim",
    name = "center-comment.vim",
    dev = vim.g.is_dev,
    keys = {
      { "<leader>cc", center_comment_any },
    },
  },

  {
    "mbbill/undotree",
    keys = {
      { "<leader><F5>", vim.cmd.UndotreeToggle },
    },
  },

  -- {
  --   "bfredl/nvim-miniyank",
  --   config = true,
  -- },

  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_theme = "light"
      vim.g.mkdp_filetypes = {
        "markdown",
      }
    end,
    ft = { "markdown" },
  },

  -- TODO: Create an autocmd to turn off file formatting in the buffer that
  --       opens using this
  {
    "chrisbra/NrrwRgn",
    lazy = false,
    keys = {
      { "<leader>nrrw", "<cmd>NR<cr>" },
    },
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opt = {},
    keys = {
      { "<leader>td", "<cmd>TodoQuickFix<cr>" },
    },
    init = function()
      require("todo-comments").setup()
    end,
  },

  {
    "chrisgrieser/nvim-scissors",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "L3MON4D3/LuaSnip",
    },
    opts = {
      snippetDir = vim.fn.stdpath("config") .. "/snippets/",
      jsonFormatter = "jq",
    },
    keys = {
      {
        "<leader>se",
        function()
          require("scissors").editSnippet()
        end,
      },
      {
        "<leader>sa",
        function()
          require("scissors").addNewSnippet()
        end,
        mode = { "x", "n" },
      },
    },
  },

  {
    "junegunn/vim-easy-align",
    init = function()
      local vis = { "v", "x" }
      local prefix = "<leader>a"
      vim.g.easy_align_ignore_groups = { "String" }
      -- TODO: There must be a nicer way of doing this with `keys = {}`?
      vim.keymap.set(vis, prefix .. "a", "<cmd>'<,'>EasyAlign<cr>")
      vim.keymap.set(vis, prefix .. "|", "<cmd>'<,'>EasyAlign<cr>")
    end,
  },

  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    ft = { "org" },
    config = function()
      -- Setup orgmode
      require("orgmode").setup({
        org_agenda_files = "~/orgfiles/**/*",
        org_default_notes_file = "~/orgfiles/refile.org",
      })
    end,
  },
}
