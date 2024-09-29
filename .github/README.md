# My Neovim Configuration

[![pre-commit](https://github.com/julianorchard/init.lua/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/julianorchard/init.lua/actions/workflows/pre-commit.yml)

This is my neovim configuration which basically is where I live most of the
time.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Installation](#installation)
  - [With Ansible](#with-ansible)
  - [Manually](#manually)
- [License](#license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Installation

There are many ways to install this but they mainly involve creating a
`~/.config/nvim` folder at some point along the way...

### With Ansible

These steps are for Ubuntu:

1. Clone my main [dotfiles](https://github.com/julianorchard/dotfiles)
   repository
2. Ensure Ansible is installed
3. `cd ansible && ./playbook --tags neovim`
4. Profit?

### Manually

```sh
mkdir -p .config/nvim
git clone git@github.com:julianorchard/init.lua.git .
```

## License

This repository is under the MIT license. See the [LICENSE](/LICENSE) file for
more information.
