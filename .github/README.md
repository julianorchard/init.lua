# My Neovim Configuration

[![pre-commit](https://github.com/julianorchard/init.lua/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/julianorchard/init.lua/actions/workflows/pre-commit.yml)

This is my neovim configuration which basically is where I live most of the
time.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Installation](#installation)
- [License](#license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Installation

I used to use a fairly normal repository and install tools with Mason. However,
I was really put off by the fact you seem to need a load of prerequisites
installed in order to get a load of LSPs working (not to mention treesitter
parsers...). So I've recently taken the plunge into using Nix and have taken
the build scripts from
[kickstart-nix.nvim](https://github.com/nix-community/kickstart-nix.nvim)! I
likely won't be syncing it with their branch as I want something that just
works, but it's a really good project that deserves a lot more attention!

You need the Nix package manager installed (I don't use NixOS the distribution
so this is what I use):

```sh
sh <(curl -L https://nixos.org/nix/install) --daemon
```

You can try before you buy:

```sh
nix run "github:julianorchard/init.lua"
```

To install, clone to anywhere on the file system and run this from the root of
this repository:

```sh
nix profile install .#nvim
```

## License

This repository is under the MIT license. See the [LICENSE](/LICENSE) file for
more information.
