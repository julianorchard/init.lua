-- https://go.dev/doc/effective_go#formatting
-- "Go has no line length limit. Don't worry about overflowing a punched card.
--  If a line feels too long, wrap it and indent with an extra tab."
vim.opt.colorcolumn = "80"
-- Ignoring that, 80 it is!

-- Indentation
vim.bo.expandtab = false
vim.bo.shiftwidth = 4
vim.bo.softtabstop = 4
vim.bo.tabstop = 4
