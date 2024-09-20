-- TODO: Is this a good way?
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.tfstate" },
  command = [[ :set filetype=json]],
})
