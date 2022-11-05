export EDITOR=nvim
export LESSHISTFILE=-
export GPG_TTY=$TTY

append_path () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}
append_path "$HOME/.local/bin"
