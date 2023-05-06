#----------------------------------------------------------------------------------------------------
# Functions
#----------------------------------------------------------------------------------------------------

# wenn using sudo root, preserve the variables
function sudo() {
    case $1 in 
        vi|vim|nvim) command sudo -E "$@";;
        *) command sudo "$@";;
    esac
}

# press Q to quit ranger and move to pwd
function ranger() {
    local IFS=$'\t\n'
    local tempfile="$(mktemp -t tmp.XXXXXX)"
    local ranger_cmd=(
    command ranger --cmd="map Q chain shell echo %d > "$tempfile"; quitall"
    )

    ${ranger_cmd[@]} "$@"
    if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$PWD" ]]; then
        cd -- "$(cat "$tempfile")" || return
    fi
    command rm -f -- "$tempfile" 2>/dev/null
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
function remove_packge() {
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
# config git repo for tum
#----------------------------------------------------------------------------------------------------
function git_tum_config() {
    git config --local user.name "Yi He"
    git config --local user.email "he0@in.tum.de"
    git config --local user.signingkey B8B647960C108C728B9C6D88E8A5C24A502A0CD5
}

#----------------------------------------------------------------------------------------------------
# disassembly utility
#----------------------------------------------------------------------------------------------------
function disasm() {
    objdump -d -C -w -Mintel $1 | vim -
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
    [[ $# -ge 1 ]] && perf record -z --call-graph=dwarf $@
    # perf script | stackcollapse-perf | flamegraph | imv -
    perf script | stackcollapse-perf | curl --data-binary @- "https://flamegraph.com" | jq ".url" | xargs xdg-open
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
