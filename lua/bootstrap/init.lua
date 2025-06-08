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

local function config_path(host, machines)
  local path = machines[host].config_path or nil
  if path == nil then
    return
  end

  local ok, _ = pcall(require, path)
  if not ok then
    print("Didn't source " .. path .. " correctly")
  end
end

local function lazy_dev_config(host, machines)
  local path = machines[host].dev_plugin_path or ""

  -- Explicit override wins 😈
  if vim.g.lazy_dev_plugin_path ~= nil then
    path = vim.g.lazy_dev_plugin_path
  end

  if path ~= "" then
    vim.g.is_dev = true
    return {
      dev = {
        path = path,
      },
    }
  end

  return {}
end

-- This provides machine specific config using os_gethostname()
local host = vim.loop.os_gethostname()
local machines = {
  ["CW-JO-LINUX"] = {
    dev_plugin_path = vim.fn.expand("~/Code/personal-gh"),
    config_path = nil,
  },
  ["MUK-00203"] = {
    dev_plugin_path = nil,
    config_path = "machines.muk",
  },
}
config_path(host, machines)

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
}, lazy_dev_config(host, machines))

require("lazy").setup({
  {
    import = "plugins",
  },
}, config)
