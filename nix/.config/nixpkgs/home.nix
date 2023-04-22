{ pkgs, ...}: 

{
  programs.home-manager.enable = true;
  home.stateVersion = "22.05";
  home.username = "yihe";
  home.homeDirectory = "/home/yihe";
  home.packages = with pkgs; [
    gcc
    python3
    nodejs
    cmake
    gnumake
    gdb

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

    rustup
    rust-analyzer
  ];
}

