# Neovim settings

{ config, lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    # Sets alias vim=nvim
    vimAlias = true;

    extraConfig = builtins.readFile ./config.vim;

    # Neovim plugins
    plugins = with pkgs.vimPlugins; [
      ctrlp
      editorconfig-vim
      tabular
      vim-markdown
       # Syntax / Language Support ##########################
      vim-nix
      vim-fish # fish

      # UI #################################################
      gruvbox # colorscheme
      vim-gitgutter # status in gutter
      # vim-devicons
      vim-airline

      # Editor Features ####################################
      vim-surround # cs"'
      vim-repeat # cs"'...
      vim-commentary # gcap
      # vim-ripgrep
      vim-indent-object # >aI
      vim-easy-align # vipga
      vim-eunuch # :Rename foo.rb
      vim-sneak
      supertab
      ale # linting
      nerdtree

      # Buffer / Pane / File Management ####################
      fzf-vim # all the things

      # Panes / Larger features ############################
      tagbar # <leader>5
      vim-fugitive # Gblame
    ];
  };
}
