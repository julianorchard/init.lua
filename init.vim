lua << EOF
  vim.loader.enable()
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

 -- All other plugins are loaded in the `./plugin/` directory - those found
 -- in this file are just legacy vim-script plugins which really need loading
 -- first
 vim.pack.add({
   "https://github.com/chaoren/vim-wordmotion",
   "https://github.com/junegunn/vim-easy-align",
   "https://github.com/mbbill/undotree",
   "https://github.com/mg979/vim-visual-multi",
   "https://github.com/tpope/vim-surround",
   "https://github.com/christoomey/vim-tmux-navigator"
 })
EOF

let g:easy_align_ignore_groups = ['String']
no <leader>aa :EasyAlign<CR>
no <leader>a\| :EasyAlign<CR>

nn <leader><F5> :UndotreeToggle<CR>

let g:tmux_navigator_no_mappings = 0
nn <C-a>h :TmuxNavigateLeft<CR>
nn <C-a>j :TmuxNavigateDown<CR>
nn <C-a>k :TmuxNavigateUp<CR>
nn <C-a>l :TmuxNavigateRight<CR>
