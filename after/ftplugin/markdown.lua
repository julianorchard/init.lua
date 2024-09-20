vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

vim.opt.spell = true

-- Easy Align <leader>\
vim.keymap.set("v", "<leader><Bslash>", [[ :EasyAlign*<Bar><Enter> ]])
