local jobid = nil

local function terminal_close()
  if not jobid then
    return
  end
  vim.fn.jobstop(jobid)
end

local function terminal_open()
  -- Target
  local file = vim.api.nvim_buf_get_name(0)
  -- Buffer config
  vim.cmd("bel new")
  vim.cmd("resize 10")
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.buflisted = false
  vim.bo.swapfile = false
  -- Open the file
  return vim.fn.termopen(file)
end

-- Inspired by how @mfussenegger does similar (but my worse version)
vim.keymap.set("n", "<leader>r", function()
  terminal_close()
  jobid = terminal_open()
end)
