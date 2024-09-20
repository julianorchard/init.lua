-- Other Aesthetics
local M = {
  {
    "j-hui/fidget.nvim",
    tag = "v1.4.5",
    config = function()
      require("config.fidget").setup()
    end,
  },
}

-- Theme map
local T = {}
local current_theme = "nightfox"

local function bg_nullify(selector)
  vim.api.nvim_set_hl(0, selector, {
    bg = "none",
    ctermbg = "none",
  })
end

-- This one goes out to the Primagen
local function colour_my_pencils(pencils)
  vim.cmd.colorscheme(pencils)

  local elms = {
    "Normal",
    "NormalFloat",
    "NormalNC",
    "EndOfBuffer",
  }
  for _, elm in ipairs(elms) do
    bg_nullify(elm)
  end
end

T.nightfox = {
  "EdenEast/nightfox.nvim",
  config = function()
    require("nightfox").setup({
      options = {
        transparent = true,
        dim_inactive_windows = true,
        styles = {
          comments = "italic",
          strings = "italic",
        },
      },
    })
    vim.cmd.colorscheme("terafox")
  end,
}

T.pinkmare = {
  "matsuuu/pinkmare",
  config = function()
    vim.opt.tgc = true
    colour_my_pencils("pinkmare")
  end,
}

T.catppuccin = {
  "catppuccin/nvim",
  name = "catppuccin",
  config = function()
    require("catppuccin").setup({
      flavour = "macchiato",
      background = {
        light = "latte",
        dark = "macchiato",
      },
      no_italic = false,
      transparent_background = true,
      cmp = true,
      gitsigns = true,
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}

T.rosepine = {
  "rose-pine/neovim",
  name = "rose-pine",
  config = function()
    require("rose-pine").setup({
      varient = "moon",
      dim_inactive_windows = true,
    })
    vim.cmd.colorscheme("rose-pine")
  end,
}

local function set_theme()
  for _, v in pairs(T) do
    v.priority = 1000
  end

  if current_theme == "pinkmare" then
    table.insert(M, T.pinkmare)
  elseif current_theme == "catppuccin" then
    table.insert(M, T.catppuccin)
  elseif current_theme == "nightfox" then
    table.insert(M, T.nightfox)
  elseif current_theme == "rose-pine" then
    table.insert(M, T.rosepine)
  else
    -- Not really tested this stuff yet
    vim.cmd("source /home/julian/.config/nvim/theme.vim")
    return {}
  end
end

set_theme()

return M
