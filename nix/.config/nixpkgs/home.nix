{ pkgs, ...}: 

{
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    gcc
    python3
    nodejs
    cmake
    gnumake

    zsh
    fzf
    ranger
    ripgrep
    fd
    stow
    exa
    aria2
    bat
    unar
    tmux
    git

    neovim
    tree-sitter
    python310Packages.pynvim

    qemu
    # qemu-utils

  ];
}

