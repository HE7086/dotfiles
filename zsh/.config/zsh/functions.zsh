#----------------------------------------------------------------------------------------------------
# Functions
#----------------------------------------------------------------------------------------------------

# wenn using sudo root, preserve the variables
function sudo() {
    case $1 in 
        vi|vim|nvim) command sudoedit "${@:2}";;
        *) command sudo "$@";;
    esac
}

# press Q to quit ranger and move to pwd
# function ranger() {
#     local IFS=$'\t\n'
#     local tempfile="$(mktemp -t tmp.XXXXXX)"
#     local ranger_cmd=(
#     command ranger --cmd="map Q chain shell echo %d > "$tempfile"; quitall"
#     )

#     ${ranger_cmd[@]} "$@"
#     if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$PWD" ]]; then
#         cd -- "$(cat "$tempfile")" || return
#     fi
#     command rm -f -- "$tempfile" 2>/dev/null
# }

function ra() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# # ex - archive extractor
function ex() {
    if [[ $# -eq 0 ]]; then
        echo "ex: archive extractor"
        echo "usage: ex <file>"
    fi
    while [[ -n "$1" ]]; do
        if [[ -f $1 ]]; then
            case $1 in
                *.tar.bz2)   tar xjf $1       ;;
                *.tbz2)      tar xjf $1       ;;
                *.tar.gz)    tar xzf $1       ;;
                *.tgz)       tar xzf $1       ;;
                *.tar)       tar xf $1        ;;
                *.bz2)       bunzip2 $1       ;;
                *.gz)        gunzip $1        ;;
                *.rar)       unrar x $1       ;;
                *.zip)       unzip $1         ;;
                *.Z)         uncompress $1    ;;
                *.7z)        7z x $1          ;;
                *.tar.zst)   tar xf $1 --zstd ;;
                *.zst)       unzstd $1        ;;
                *.tar.xz)    tar xJf $1       ;;
                *.xz)        xz -d $1         ;;
                *)           echo "Unknown file: $1" >&2;;
            esac
        else
            echo "Not a file: $1" >&2
        fi
        shift
    done
}


#----------------------------------------------------------------------------------------------------
# pdfgrep
#----------------------------------------------------------------------------------------------------
function findpdf() {
    find . -iname "*.pdf" -exec pdfgrep -i "$*" {} +
}

#----------------------------------------------------------------------------------------------------
# clipboard for x11 and wayland
#----------------------------------------------------------------------------------------------------
function clip() {
    if [[ "$XDG_SESSION_TYPE" = "wayland" ]]; then
        wl-copy
    else
        xclip -selection c
    fi
}

#----------------------------------------------------------------------------------------------------
# remove package recursively without touching other packages' optional deps
#----------------------------------------------------------------------------------------------------
function remove_package() {
    if [[ $# -ne 0 ]]; then
        sudo pacman -R "$*"
    fi

    while [[ -n $(pacman -Qdtq) ]]; do
        sudo pacman -R --noconfirm $(pacman -Qdtq)
    done
}

#----------------------------------------------------------------------------------------------------
# dd wrapper
#----------------------------------------------------------------------------------------------------
function dd_write_disk() {
    sudo dd bs=4M if=$1 of=$2 conv=fsync oflag=direct status=progress
    sync
}

#----------------------------------------------------------------------------------------------------
# disassembly utility
#----------------------------------------------------------------------------------------------------
function disasm() {
    objdump -d -C -w -Mintel $@ | vim -
}

function gui() {
    if [[ $1 = "w" ]]; then
        export XDG_SESSION_TYPE=wayland
        export QT_QPA_PLATFORM=wayland
        startplasma-wayland
    else
        startx ~/.config/X11/xinitrc
    fi
}

function mkd() {
    mkdir -p $1 && cd $1
}

function perflame() {
    if [[ $# -ge 1 ]]; then
        if ! command -v $1 > /dev/null; then
            if command -v $PWD/$1 > /dev/null; then
                1=$PWD/$1
            else
                echo "command not found: $1"
                return 1
            fi
        fi
        perf record -z --call-graph=dwarf $@
    fi
    perf script | stackcollapse-perf | curl --data-binary @- "https://flamegraph.com" | jq ".url" | xargs xdg-open
}

function perflame2() {
    if [[ $# -ge 1 ]]; then
        if ! command -v $1 > /dev/null; then
            if command -v $PWD/$1 > /dev/null; then
                1=$PWD/$1
            else
                echo "command not found: $1"
                return 1
            fi
        fi
        perf record -g $@
    fi
    perf script | stackcollapse-perf | flamegraph | imv -
}

function nix() {
    case $1 in
        build|shell|develop)
            command nom $@
            ;;
        *)
            command nix $@
            ;;
    esac
}

function path() {
    if [[ -n $path ]]; then
        printf '%s\n' $path | nl
    else
        echo $PATH | sed 's/:/\n/g' | nl
    fi
}

function ssh-exit() {
    for socket in ~/.ssh/ssh-*@*:*; do
        if [[ -S "$socket" ]]; then
            echo $socket
            ssh -S "$socket" -O exit "$socket"
        fi
    done
}

# function bkup() {
#     [[ $# -lt 2 ]] && echo "usage: bkup <src> <dst>" && return 0;

#     SRC=$1
#     HOST=${2%:*}
#     DIR=${2#*:}
#     RSYNC='rsync --archive -hh --partial --info=stats1 --info=progress2 --modify-window=1 --delete'

#     if ssh $HOST "test -e $DIR/lastupdate"; then 
#         REMOTE_TIMESTAMP=$(ssh $HOST "cat $DIR/lastupdate")
#         LASTUPDATE=$(cat "$SRC/lastupdate")

#         if [[ $REMOTE_TIMESTAMP -gt $LASTUPDATE ]]; then
#             echo "Remote is newer than local!"
#             $(RSYNC)
#         else
#             echo "Local is newer than remote!"
#             $(RSYNC) "$1" "$2"
#         fi
#     else
#         echo "Remote timestamp not found."
#         return 1
#     fi

#     echo $(date +%s) > "$SRC/lastupdate"

# }

# function cursor_mode() {
#     cursor_block='\e[2 q'
#     cursor_beam='\e[6 q'

#     function zle-keymap-select {
#         if [[ ${KEYMAP} == vicmd ]] ||
#             [[ $1 = 'block' ]]; then
#             echo -ne $cursor_block
#         elif [[ ${KEYMAP} == main ]] ||
#             [[ ${KEYMAP} == viins ]] ||
#             [[ ${KEYMAP} = '' ]] ||
#             [[ $1 = 'beam' ]]; then
#             echo -ne $cursor_beam
#         fi
#     }

#     zle-line-init() {
#         echo -ne $cursor_beam
#     }

#     zle -N zle-keymap-select
#     zle -N zle-line-init
# }
# cursor_mode


function terminfo() {
    # https://ghostty.org/docs/help/terminfo
    infocmp -x | ssh $1 -- tic -x -
}

function ns() {
  nix shell "nixpkgs#$@"
}
