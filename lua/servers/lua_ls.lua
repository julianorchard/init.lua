return {
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          -- Neovim
          "vim",
          -- Awesome
          "awesome",
          "client",
          "screen",
          "tag",
        },
      },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}
