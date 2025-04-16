-- local cmp = require("cmp_nvim_lsp")
local cmp = require("blink.cmp")
local icons = require("helpers.icons")
local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")
local picker = require("telescope.builtin")

local M = {}

function M.setup()
  -- Diagnostic keymaps
  vim.keymap.set("n", "[", vim.diagnostic.goto_prev)
  vim.keymap.set("n", "]", vim.diagnostic.goto_next)
  vim.keymap.set("n", "<leader>gh", vim.diagnostic.open_float)
  vim.keymap.set("n", "<leader>gl", vim.diagnostic.setloclist)

  local on_attach = function(_, bufnr)
    -- Most useful (but I don't often get to use them)
    vim.keymap.set("n", "<leader>gc", vim.lsp.buf.rename, { buffer = bufnr })
    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { buffer = bufnr })
    vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, { buffer = bufnr })

    vim.keymap.set("n", "<leader>ga", vim.lsp.buf.code_action, { buffer = bufnr })
    vim.keymap.set("n", "<leader>gr", picker.lsp_references, { buffer = bufnr })
    vim.keymap.set("n", "<leader>gI", picker.lsp_implementations, { buffer = bufnr })
    vim.keymap.set("n", "<leader>ds", picker.lsp_document_symbols, { buffer = bufnr })
    vim.keymap.set("n", "<leader>ws", picker.lsp_dynamic_workspace_symbols, { buffer = bufnr })

    -- Lesser used LSP functionality
    -- vim.keymap.set("<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { buffer = bufnr })
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, { buffer = bufnr })
    vim.keymap.set("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, { buffer = bufnr })
  end

  -- Server capabilities: keeping this stuff for now
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = cmp.get_lsp_capabilities()

  local config_path = vim.fn.stdpath("config") .. "/lua/servers"
  local files = vim.fn.globpath(config_path, "*.lua", false, true)

  -- Look at lua/servers/*.lua files for LSP configs
  local servers = {}
  for _, file in ipairs(files) do
    -- https://neovim.io/doc/user/builtin.html#fnamemodify()
    local name = vim.fn.fnamemodify(file, ":t:r")

    local server_exist, config = pcall(require, "servers." .. name)
    if not server_exist then
      vim.notify("Error loading LSP config for " .. name .. ": " .. config, vim.log.levels.ERROR)
      config = {}
    end

    servers[name] = config == true and {} or config
  end

  -- Ensure the servers above are installed
  local install_list = {}

  if vim.g.mason_autoinstall == true then
    install_list = vim.tbl_keys(servers)
  end

  mason_lspconfig.setup({
    ensure_installed = install_list,
  })

  mason_lspconfig.setup_handlers({
    function(server_name)
      -- or {} to cover anything installed outside of this code
      local config = servers[server_name] or {}
      config.capabilities = capabilities
      config.on_attach = on_attach

      lspconfig[server_name].setup(config)
    end,
  })

  -- Custom signs
  local signs = icons.diagnostics
  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = signs.Error,
        [vim.diagnostic.severity.WARN] = signs.Warn,
        [vim.diagnostic.severity.INFO] = signs.Info,
        [vim.diagnostic.severity.HINT] = signs.Hint,
      },
    },
    virtual_text = true,
    underline = true,
    update_in_insert = false,
  })

  vim.filetype.add({
    extension = {
      jenkins = "groovy",
    },
  })
end

M.setup()

return M
