export ZDOTDIR=$HOME/.config/zsh
export EDITOR=nvim
export VISUAL=nvim
export BROWSER=firefox
export LESSHISTFILE=-
export GPG_TTY=$TTY
export MANPAGER='sh -c "col -bx | bat -pl man"'
export MANROFFOPT='-c'
export LESS='-R'

typeset -U PATH path
path=(
    ~/.local/bin
    $path
)
