vim.g.mapleader = " "

vim.g.maplocalleader = " "

vim.g.mkdp_theme = "light"

vim.g.theme = "vague"

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

vim.g.dependencies = vim.list_extend(formatters, linters)
