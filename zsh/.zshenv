export ZDOTDIR=$HOME/.config/zsh
export EDITOR=nvim
export VISUAL=nvim
export BROWSER=firefox
export LESSHISTFILE=-
export GPG_TTY=$TTY
export MANPAGER='sh -c "col -bx | bat -pl man"'
export MANROFFOPT='-c'

typeset -U PATH path
path=(
    ~/.nix-profile/bin
    ~/.local/bin
    $path
)

fpath=(
    $HOME/dotfiles/Submodules/zsh-completions/src
    $fpath
)
