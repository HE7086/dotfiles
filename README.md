# DotFile

* controlled by GNU stow
* install dotfiles with `make`
* automatically create symbolic link
* install single file with `stow <package name> --target=$HOME`
* install single file to root with `sudo stow <package name> --target=/`

## required additional packages
* shell
```
fzf
thefuck
zsh-autosuggestions
zsh-completions
zsh-history-substring-search
zsh-syntax-highlighting
zsh-theme-powerlevel10k
```

* LSP
```
bash-language-server
clangd
haskell-language-server
```
