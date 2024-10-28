local icons = require("helpers.icons")
local helpers_available, h = pcall(require, "helpers.functions")
if not helpers_available then
  return nil
end

local M = {}

function M.setup()
  -- Diagnostic keymaps
  vim.keymap.set("n", "[", vim.diagnostic.goto_prev)
  vim.keymap.set("n", "]", vim.diagnostic.goto_next)
  vim.keymap.set("n", "<leader>gh", vim.diagnostic.open_float)
  vim.keymap.set("n", "<leader>gl", vim.diagnostic.setloclist)

  local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }

    -- Most useful (but I don't often get to use them)
    h.map("n", "<leader>gc", vim.lsp.buf.rename, opts)
    h.map("n", "<leader>gd", vim.lsp.buf.definition, opts)
    h.map("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    h.map("n", "<leader>K", vim.lsp.buf.hover, opts)

    h.map("n", "<leader>ga", vim.lsp.buf.code_action, opts)
    h.map("n", "<leader>gr", require("telescope.builtin").lsp_references, opts)
    h.map("n", "<leader>gI", require("telescope.builtin").lsp_implementations, opts)
    h.map("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, opts)
    h.map("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, opts)

    -- Lesser used LSP functionality
    -- h.map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    h.map("n", "gD", vim.lsp.buf.declaration, opts)
    h.map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
    h.map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
    h.map("n", "<leader>wl", function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
  end

  -- Servers which don't need any configuring here
  local unconfigured = {
    cssls = true,
    dockerls = true,
    gopls = true,
    groovyls = true,
    html = true,
    jsonnet_ls = true,
    ocamllsp = true,
    pyright = true,
    terraformls = true,
  }
  -- Servers which ARE configured
  local servers = {
    -- TODO: Evaluate
    intelephense = {
      stubs = {
        -- Surely we get Core for free?
        "Core",
        -- "Reflection",
        -- "SPL",
        -- "SimpleXML",
        -- "ctype",
        -- "date",
        -- "exif",
        -- "filter",
        -- "imagick",
        -- "json",
        -- "pcre",
        -- "random",
        -- "standard",
      },
    },
    jsonls = {
      json = {
        schemas = require("schemastore").json.schemas(),
      },
    },
    yamlls = {
      yaml = {
        customTags = {
          "!reference sequence", -- This was extremely hard to figure out
          "!ImportValue",
        },
        schemaStore = require("schemastore").yaml.schemas(),
        schemas = {
          kubernetes = "*.yaml",
          ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
          ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
          ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = "azure-pipelines*.{yml,yaml}",
          ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/tasks"] = "roles/tasks/*.{yml,yaml}",
          ["https://raw.githubusercontent.com/ansible/ansible-lint/main/src/ansiblelint/schemas/ansible.json#/$defs/playbook"] = "*play*.{yml,yaml}",
          ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
          ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
          ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
          ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
          ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*gitlab-ci*.{yml,yaml}",
          ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
          ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
          ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
        },
        hover = true,
      },
    },
    lua_ls = {
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
    ts_ls = {},
  }
  for k, v in pairs(unconfigured) do
    if v == true then
      servers[k] = {}
    end
  end

  -- Enable the following language servers

  -- NOTE: We're using :link.cmp now though
  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  -- local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  -- Custom signs
  local signs = icons.diagnostics
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    -- TODO: Update this please
    -- vim.diagnostic.config({
    --   signs = {
    --     text = {
    --       [vim.diagnostic.severity.ERROR] = "<icon_string>",
    --       [vim.diagnostic.severity.WARN] = "<icon_string>",
    --       [vim.diagnostic.severity.INFO] = "<icon_string>",
    --       [vim.diagnostic.severity.HINT] = "<icon_string>",
    --     },
    --   },
    -- })

    -- NOTE: This is depreciated
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

M.setup()
