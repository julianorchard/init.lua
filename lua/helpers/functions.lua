local M = {}

---Write content (content) to a file (filename)
---@param filename string
---@param content string
M.write_file = function(filename, content)
  local file, err = io.open(filename, "w")
  if not file then
    error("Failed to open file: " .. err)
  end
  file:write(content)
  file:close()
end

---A pseudo-random string (from https://gist.github.com/haggen/2fd643ea9a261fea2094?permalink_comment_id=4496204#gistcomment-4496204)
---@param len number The length of the random string
---@return string # string
M.rng = function(len)
  return tostring({}):sub(len)
end

---table_contains
---Find out if a table contains a value
---@param tbl table The input table
---@param x any The value to find
---@return boolean # The result of the search
M.table_contains = function(tbl, x)
  for _, v in pairs(tbl) do
    if v == x then
      return true
    end
  end
  return false
end

---Insert string at point in normal mode
---@param insert_string string The string to insert
function M.insert_at_point(insert_string)
  local cursor_x = vim.api.nvim_win_get_cursor(0)[2]
  local cursor_y = vim.api.nvim_get_current_line()
  -- Set current line as new content
  vim.api.nvim_set_current_line(
    cursor_y:sub(0, cursor_x)
      .. " "
      .. insert_string
      .. cursor_y:sub(cursor_x + 1)
  )
end

---Fills line until the first colour column with a character of choice!
---Not sure if there's a better way to do this, but this is how I've done it...!
---Fill functionality <C-t> (this ->) ------------------------------------------
---Call with any char using the following command ------------------------------
---`:lua M.fill("+")` == this -> +++++++++++++++++++++++++++++++++++++++++++++++
---@param character? string The character to insert until the colour column
function M.fill(character)
  local cc = vim.api.nvim_win_get_option(0, "cc") - #vim.fn.getline(".")
  local line_length = vim.split(cc, ",")[1]
  if line_length > 2 then
    -- Default to '-' (dash) character if no input is provided
    M.insert_at_point(string.rep((character and character or "-"), line_length))
  else
    print("ERROR: Cannot fill at this point.")
  end
end

---Wrapper around keymap with silent and noremap
---@param mode string|table Which mode(s) the map should be set in
---@param lhs string The lhs part of the remap
---@param rhs string|function The rhs part of the remap
function M.map(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, {
    noremap = true,
    silent = true,
  })
end

return M

-- vi: ft=lua
