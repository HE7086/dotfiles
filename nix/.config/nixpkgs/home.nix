{ pkgs, ...}:

let
  unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) {};
in
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
    llvmPackages.clang-unwrapped

    zsh
    fzf
    ranger
    ripgrep
    fd
    stow
    eza
    aria2
    bat
    unar
    tmux
    git
    just

    # neovim
    unstable.neovim
    tree-sitter
    python310Packages.pynvim

    qemu
    # qemu-utils

    rustup
    rust-analyzer

    picocom
    kubernetes
  ];
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  # home.file = {
  #   "dotfiles" = {
  #     source = pkgs.fetchFromGitHub {
  #       owner = "HE7086";
  #       repo = "dotfiles";
  #       rev = "dc6942f57d8809132565aee35cbd10f0434e6c0a";
  #       sha256 = "Sa1XjYBXIXQ0xyFNddJhDyBn+wZLhs2Yp2+yNm2SLMo=";
  #       leaveDotGit = true;
  #     };
  #     recursive = true;
  #   };
  # };
}
