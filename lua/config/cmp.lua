local luasnip = require("luasnip")

local M = {}

function M.setup()
  local cmp = require("cmp")

  require("luasnip.loaders.from_vscode").lazy_load({
    paths = "/home/julian/.config/nvim/snippets",
  })

  luasnip.config.setup()

  local cmp_select = { behavior = cmp.SelectBehavior.Select }
  cmp.setup({

    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },

    mapping = cmp.mapping.preset.insert({
      ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
      ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
      ["<C-Space>"] = cmp.mapping.complete({}),
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
    }),

    sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "orgmode" },
      { name = "rg" },
    },

    window = {
      completion = {
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
        col_offset = -3,
        side_padding = 0,
      },
    },

    formatting = {
      format = function(entry, vim_item)
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          rg = "[Grep]",
          org = "[Org]",
        })[entry.source.name]
        return vim_item
      end,
    },
  })
end

M.setup()

return M
