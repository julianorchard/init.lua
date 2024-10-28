{inputs}: final: prev:
with final.pkgs.lib; let
  pkgs = final;

  # Make sure we use the pinned nixpkgs instance for wrapNeovimUnstable,
  # otherwise it could have an incompatible signature when applying this overlay:
  pkgs-wrapNeovim = inputs.nixpkgs.legacyPackages.${pkgs.system};

  # This is the helper function that builds the Neovim derivation:
  mkNeovim = pkgs.callPackage ./mkNeovim.nix { inherit pkgs-wrapNeovim; };

  all-plugins = with pkgs.vimPlugins; [
    # TODO: Maybe add these sometime
    # nvim-scissors
    # cd-project-nvim
    luasnip
    NrrwRgn
    blink-cmp
    SchemaStore-nvim
    conform-nvim
    diffview-nvim
    fidget-nvim
    friendly-snippets
    gitsigns-nvim
    jinja-vim
    markdown-preview-nvim
    neogit
    nightfox-nvim
    nvim-lint
    nvim-lspconfig
    nvim-moonwalk
    nvim-treesitter
    nvim-treesitter-context
    nvim-treesitter-refactor
    nvim-treesitter-textobjects
    oil-nvim
    orgmode
    plenary-nvim
    telescope-fzf-native-nvim
    telescope-nvim
    todo-comments-nvim
    undotree
    vim-easy-align
    vim-fugitive
    vim-helm
    vim-surround
    vim-visual-multi
    vim-vp4
    vim-wordmotion
    virtual-types-nvim
  ];

  extraPackages = with pkgs; [
    ansible-lint
    black
    gopls
    haskellPackages.hadolint
    jq
    lua-language-server
    nil
    nodePackages.bash-language-server
    nodePackages.prettier
    nodePackages.typescript-language-server
    nodePackages.vim-language-server
    nodePackages.yaml-language-server
    nodejs_22
    shfmt
    terraform-ls
  ];
in {
  nvim-pkg = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
  };

  # This can be symlinked in the devShell's shellHook:
  nvim-luarc-json = final.mk-luarc-json {
    plugins = all-plugins;
  };
}
