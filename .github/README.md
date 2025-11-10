# My Neovim Configuration

[![pre-commit](https://github.com/julianorchard/init.lua/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/julianorchard/init.lua/actions/workflows/pre-commit.yml)

This is my Neovim configuration which basically is where I live most of the
time.

Requires `v0.12.0` or later!

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Installation](#installation)
- [Plugins](#plugins)
- [License](#license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Installation

I mainly install with Ansible:

1. Ensure Ansible is installed (`python3 -m pip install --user ansible`)
2. Clone this repo:

```sh
mkdir -p .config/nvim
git clone git@github.com:julianorchard/init.lua.git .
```

3. `cd ansible && ./playbook.yml`
4. Profit?

## Plugins

Here's a list of plugins I use (generated with `./bin/docs-gen.vim`):

<!--BEGIN_PLUGIN_LIST-->
- [vim-surround](https://github.com/tpope/vim-surround)
- [undotree](https://github.com/mbbill/undotree)
- [vim-easy-align](https://github.com/junegunn/vim-easy-align)
- [friendly-snippets](https://github.com/rafamadriz/friendly-snippets)
- [mason.nvim](https://github.com/mason-org/mason.nvim)
- [vim-peekaboo](https://github.com/junegunn/vim-peekaboo)
- [go-up.nvim](https://github.com/nullromo/go-up.nvim)
- [fzf-lua](https://github.com/ibhagwan/fzf-lua)
- [citruszest.nvim](https://github.com/zootedb0t/citruszest.nvim)
- [conform.nvim](https://github.com/stevearc/conform.nvim)
- [fidget.nvim](https://github.com/j-hui/fidget.nvim)
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip)
- [vim-fugitive](https://github.com/tpope/vim-fugitive)
- [snacks.nvim](https://github.com/folke/snacks.nvim)
- [oil.nvim](https://github.com/stevearc/oil.nvim)
- [blink.cmp](https://github.com/Saghen/blink.cmp)
- [vim-wordmotion](https://github.com/chaoren/vim-wordmotion)
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
- [SchemaStore.nvim](https://github.com/b0o/SchemaStore.nvim)
- [vim-visual-multi](https://github.com/mg979/vim-visual-multi)
- [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)
- [cd-project.nvim](https://github.com/LintaoAmons/cd-project.nvim)
- [blink-emoji.nvim](https://github.com/moyiz/blink-emoji.nvim)
- [blink-ripgrep.nvim](https://github.com/mikavilpas/blink-ripgrep.nvim)
- [vague.nvim](https://github.com/vague2k/vague.nvim)
- [log-highlight.nvim](https://github.com/fei6409/log-highlight.nvim)
<!--END_PLUGIN_LIST-->

## License

This repository is under the MIT license. See the [LICENSE](/LICENSE) file for
more information.
