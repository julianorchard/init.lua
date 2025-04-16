require("bootstrap.globals")

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

local box_paths = {
  ["CW-JO-LINUX"] = vim.fn.expand("~/Code/personal-gh"),
}

local function lazy_dev_config()
  local host = vim.loop.os_gethostname()
  local path = box_paths[host] or ""

  -- Explicit override wins 😈
  if vim.g.lazy_dev_path ~= nil then
    path = vim.g.lazy_dev_path
  end

  if path ~= "" then
    return {
      dev = {
        path = path,
      },
    }
  end

  return {}
end

local config = vim.tbl_deep_extend("force", {
  checker = {
    enabled = true,
    check_pinned = true,
    frequency = 86400, -- "Every day is lazy day"
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "netrw",
        "netrwPlugin",
      },
    },
  },
}, lazy_dev_config())

require("lazy").setup({
  {
    import = "plugins",
  },
}, config)
