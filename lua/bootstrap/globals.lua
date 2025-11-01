-- Le leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Le theme
vim.g.theme = "vague"

-- Automatically install Mason packages
vim.g.mason_autoinstall = false

local formatters = {
  "black",
  "jq",
  "jsonnetfmt",
  "prettier",
  "shfmt",
  "stylua",
  "yamlfix",
}

local linters = {
  "hadolint",
  "ansible-lint",
}

-- All dependencies as a big list
vim.g.dependencies = vim.list_extend(formatters, linters)

-- Does the machine have a dev plugin configuration directory?
vim.g.is_dev = false

-- Auto open the terminal for debugs
vim.g.terminal_debug = false
vim.g.terminal_auto_open = false
