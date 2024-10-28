local M = {}

function M.setup()
  local lint = require("lint")
  local linters = lint.linters

  lint.linters_by_ft = {
    ["yaml.ansible"] = { "ansible_lint" },
    dockerfile = { "hadolint" },
    php = { "phpstan" },
    -- TODO: Evaluate
    -- ghaction = { "actionlint" },
    nunjucks = { "curlylint" },
  }

  -- Hadolint config
  linters.hadolint.args = {
    "-f",
    "json",
    "--ignore",
    "DL3008",
    "-",
  }

  vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
    group = vim.api.nvim_create_augroup("lint", { clear = true }),
    callback = function()
      lint.try_lint()
    end,
  })
end

M.setup()

return M
