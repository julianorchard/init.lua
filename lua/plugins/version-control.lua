local function fugimap(a, b, c)
  local cmd = string.format([[ <cmd>Git %s<cr> ]], c)
  vim.keymap.set(a, b, cmd, {
    noremap = true,
    silent = true,
  })
end

local function p4map(a, b, c)
  local cmd = string.format([[ <cmd>Vp4%s<cr> ]], c)
  vim.keymap.set(a, b, cmd, {
    noremap = true,
    silent = true,
  })
end

return {

  {
    "NeogitOrg/neogit",
    config = true,
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      {
        "<leader>go",
        "<cmd>Neogit<cr>",
      },
    },
    init = function()
      require("neogit").setup({
        disable_signs = true,
        use_icons = false,
      })
    end,
  },

  {
    "tpope/vim-fugitive",
    cmd = "Git",
    init = function()
      fugimap("n", "<leader>gb", "blame")
      fugimap("n", "<leader>gd", "diff")
      fugimap("n", "<leader>gl", "log")
      fugimap("n", "<leader>gs", "status")
      fugimap("n", "<leader>ga", "add .")
      fugimap("n", "<leader>gp", "push")
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },

  {
    "ngemily/vim-vp4",
    event = "VeryLazy",
    init = function()
      p4map("n", "<leader>4c", "Change")
      p4map("n", "<leader>4d", "Describe")
      p4map("n", "<leader>4e", "Edit")
      p4map("n", "<leader>4r", "Reopen")
      p4map("n", "<leader>4u", "Revert")
    end,
  },
}
