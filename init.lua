vim.loader.enable()
vim.lsp.set_log_level("off")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.mkdp_theme = "light"

vim.g.theme = "vague"
vim.g.mason_autoinstall = false -- Does not use "mason" or "mason tool installer" to install stuff automagically
vim.g.dependencies = {
  -- Formatters
  "black",
  "jq",
  "jsonnetfmt",
  "prettier",
  "shfmt",
  "stylua",
  "yamlfix",
  -- Linters
  "hadolint",
  "ansible-lint",
  "phpstan",
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "plugins" },
}, {
  checker = {
    enabled = true,
    check_pinned = true,
    frequency = 86400,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "netrw",
        "netrwPlugin",
      },
    },
  },
  dev = {
    path = "~/Code/personal-gh/",
  },
})
