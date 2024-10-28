require("blink.cmp").setup({
  keymap = {
    select_prev = { "<Up>", "<C-k>" },
    select_next = { "<Down>", "<C-j>" },
    accept = { "<CR>", "<C-CR>" },
  },
  sources = {
    completion = {
      enabled_providers = { "lsp", "path", "snippets", "buffer" },
      -- TODO: Add ripgreps
      -- "ripgrep" },
    },
  },
})
