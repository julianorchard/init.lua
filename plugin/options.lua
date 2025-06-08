-- Idea to use the plugin/ directory for this stolen from TJ
local function opts_setup()
  local tab_default = 4
  local options = {
    wo = {
      number = true,
      -- Keep signcolumn on by default
      signcolumn = "yes",
    },
    o = {
      hlsearch = false,
      mouse = "a",
      -- Save undo history
      undofile = true,
      -- Case-insensitive searching UNLESS \C or capital in search
      ignorecase = true,
      smartcase = true,
      -- Decrease update time
      updatetime = 250,
      timeoutlen = 300,
      -- Set completeopt to have a better completion experience
      completeopt = "menuone,noselect",
    },
    opt = {
      encoding = "UTF-8",
      history = 1000,
      -- Set highlight on search
      -- Okay this is amazing wtf
      inccommand = "split",
      -- Make line numbers default
      -- Text width/wrap/offsets
      scrolloff = 13,
      -- TODO: Line break at a certin point
      -- textwidth = 80
      wrap = false,
      -- Line numbering
      number = true,
      relativenumber = true,
      -- Indentation
      autoindent = true,
      smartindent = true,
      -- Tab
      expandtab = true,
      shiftwidth = tab_default,
      softtabstop = tab_default,
      tabstop = tab_default,
      -- Char icons
      list = true,
      listchars = "tab:| ,nbsp:␣",
      spelllang = { "en" },
      -- Update time
      updatetime = 500,
      -- Colour column
      colorcolumn = "80",
      -- Highlight cursor
      cursorline = true,
      cursorcolumn = true,

      -- Global conceal level
      -- conceallevel = 2,
    },
  }

  -- The idea for this kinda thing taken from @ellisonleao on GitHub
  for k1, v1 in pairs(options) do
    for k2, v2 in pairs(v1) do
      vim[k1][k2] = v2
    end
  end

  vim.g.custom_conceal = true
  vim.opt.path:append("**")
end

opts_setup()
