lua << EOF
  vim.loader.enable()
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  -- I'm excited there's a HALF decent plugin manager built into Neovim now...
  -- but really?!
  --
  -- If this isn't done literally first thing (e.g., if you want to make
  -- multiple calls to vim.pack.add() to add packages in a more complicated
  -- way) it has real trouble with that
  vim.pack.add({
    -- the classiques
    "https://github.com/chaoren/vim-wordmotion",
    "https://github.com/junegunn/vim-easy-align",
    "https://github.com/mbbill/undotree",
    "https://github.com/mg979/vim-visual-multi",
    "https://github.com/tpope/vim-surround",
    "https://github.com/christoomey/vim-tmux-navigator",
    "https://github.com/junegunn/vim-peekaboo",

    -- aesthetics
    { src = "https://github.com/j-hui/fidget.nvim", version = "v1.5.0" },
    { src = "https://github.com/nullromo/go-up.nvim" },
    { src = "https://github.com/fei6409/log-highlight.nvim" },
    { src = "https://github.com/folke/snacks.nvim" },
    "https://github.com/zootedb0t/citruszest.nvim",
    -- "https://github.com/vague2k/vague.nvim",

    -- lsp/completion/formatting
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/b0o/SchemaStore.nvim" },
    "https://github.com/rafamadriz/friendly-snippets",
    "https://github.com/moyiz/blink-emoji.nvim",
    "https://github.com/mikavilpas/blink-ripgrep.nvim",
    "https://github.com/L3MON4D3/LuaSnip",
    { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("^1") },

    -- navigation
    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/LintaoAmons/cd-project.nvim" },

    -- version control
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/tpope/vim-fugitive" },
  })
EOF

let g:easy_align_ignore_groups = ['String']
no <leader>aa :EasyAlign<CR>
no <leader>a\| :EasyAlign<CR>

nn <leader><F5> :UndotreeToggle<CR>

let g:tmux_navigator_no_mappings = 1
nn <C-a>h :TmuxNavigateLeft<CR>
nn <C-a>j :TmuxNavigateDown<CR>
nn <C-a>k :TmuxNavigateUp<CR>
nn <C-a>l :TmuxNavigateRight<CR>

" Get the vim hightlighting under the cursor
nnoremap <leader>hi :echo synIDattr(synID(line('.'), col('.'), 1), 'name')<CR>
