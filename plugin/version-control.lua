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
