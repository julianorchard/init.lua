local helpers_available, h = pcall(require, "helpers.functions")
if not helpers_available then
  return nil
end

local M = {}

function M.lua_ls_config()
  local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }
    h.map("n", "<leader>gc", vim.lsp.buf.rename, opts)
    h.map("n", "<leader>gd", vim.lsp.buf.definition, opts)
    h.map("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    h.map("n", "<leader>K", vim.lsp.buf.hover, opts)
    h.map("n", "<leader>ga", vim.lsp.buf.code_action, opts)
    h.map("n", "<leader>gr", require("telescope.builtin").lsp_references, opts)
    h.map("n", "<leader>gI", require("telescope.builtin").lsp_implementations, opts)
    h.map("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, opts)
    h.map("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, opts)
    h.map("n", "gD", vim.lsp.buf.declaration, opts)
    h.map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
    h.map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
    h.map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
  end

  local settings = {
    Lua = {
      diagnostics = {
        globals = {
          "vim",
        },
      },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  }

  local capabilities = vim.lsp.protocol.make_client_capabilities()

  require("lspconfig")["lua_ls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = settings,
    runtime = {
      version = "LuaJIT",
    },
    hint = {
      enable = true,
    },
  })
end

M.lua_ls_config()

return M
