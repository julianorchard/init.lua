local M = {}

function M.setup()
  require("fidget").setup({
    progress = {
      display = {
        done_icon = "DONE",
        format_group_name = function(group)
          return tostring("LSP " .. group)
        end,
        progress_icon = {
          -- NOTE: This was also not well documented: someone was not answered
          --       in the GitHub Issues about it and it had been asked before:
          pattern = { "foo", "bar", "baz", "qux", "quux", "quuux" },
          -- pattern = "line",
          period = 1,
        },
      },
    },
    notification = {
      -- This took me fucking forever to figure out...
      configs = {
        default = vim.tbl_extend(
          "force",
          require("fidget.notification").default_config,
          {
            name = "NOTIFICATION",
            icon = "<",
            ttl = 7,
          }
        ),
      },
      -- ^^
      -- Maybe open an issue about this in the GitHub Issues because damn; this
      -- was a little burried and is basically extremely useful
      filter = vim.log.levels.INFO,
      history_size = 128,
      override_vim_notify = true,
      view = {
        stack_upwards = false,
        icon_separator = " ",
        group_separator = "--",
        group_separator_hl = "Comment",
        render_message = function(msg, cnt)
          return cnt == 1 and msg or string.format("(%dx) %s", cnt, msg)
        end,
      },
      window = {
        border = "rounded",
        zindex = 45,
        max_width = 0,
        max_height = 0,
        x_padding = 0,
        y_padding = 0,
        align = "top",
      },
    },
  })
end

function M.test()
  vim.notify("testing this notification")
  vim.notify("testing dvhis notification")
  vim.notify("tethis n")
end

M.setup()
M.test()

return M
