local M = {}

M.setup = function()
  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.org = {
    install_info = {
      url = "https://github.com/milisims/tree-sitter-org",
      revision = "main",
      files = { "src/parser.c", "src/scanner.c" },
    },
    filetype = "org",
  }
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "bash",
      "css",
      "csv",
      "groovy",
      "javascript",
      "jsonnet",
      "lua",
      "markdown",
      "markdown_inline",
      "ocaml",
      "org",
      "scss",
      "terraform",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    },
    auto_install = true,
    highlight = {
      additional_vim_regex_highlighting = false,
      enable = true,
      use_language_tree = true,
      disable = function(_, buf)
        local max_filesize = 100 * 1024
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
    },
    indent = {
      enable = true,
    },
    sync_install = false,
    modules = {},
    ignore_install = { "org" },
    refactor = {
      smart_rename = {
        enable = true,
        keymaps = {
          smart_rename = "<leader>rn",
        },
      },
    },
  })
end

M.setup()

return M
