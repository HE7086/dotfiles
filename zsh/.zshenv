export ZDOTDIR=$HOME/.config/zsh
export EDITOR=nvim
export LESSHISTFILE=-
export GPG_TTY=$TTY

typeset -U PATH path
path=(
    ~/.local/bin
    $path
)
