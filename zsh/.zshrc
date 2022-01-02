#----------------------------------------------------------------------------------------------------
# completion settings
#----------------------------------------------------------------------------------------------------
autoload -Uz compinit && compinit -d $ZCOMPDUMPFILE
setopt globdots

setopt complete_aliases
setopt auto_menu
setopt complete_in_word
setopt always_to_end
zmodload zsh/complist

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' list-colors ''
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

# cd options
setopt autocd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_minus

setopt interactive_comments
setopt auto_continue
# setopt extended_glob
setopt listpacked
setopt magic_equal_subst

# rm option
setopt rm_star_silent

# setup cache directory if not exist
[[ -d ~/.cache/zsh ]] || mkdir -p ~/.cache/zsh;

#----------------------------------------------------------------------------------------------------
# history settings
#----------------------------------------------------------------------------------------------------
HISTORY_IGNORE="(ls|l|ll|cd|pwd|exit|vim|.|..|...)"
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_find_no_dups
setopt hist_save_no_dups
setopt hist_verify
setopt hist_reduce_blanks
setopt inc_append_history
setopt share_history

#----------------------------------------------------------------------------------------------------
# prompt settings
#----------------------------------------------------------------------------------------------------
# autoload -Uz promptinit && promptinit
# prompt redhat
autoload -U colors && colors
# only show right prompt on newest line
setopt transient_rprompt
setopt prompt_subst

#----------------------------------------------------------------------------------------------------
# Plugin Settings
#----------------------------------------------------------------------------------------------------

# FZF
if (which fzf > /dev/null); then 
    if [[ -f /usr/bin/fzf ]]; then
        [[ $- == *i* ]] && source /usr/share/fzf/completion.zsh 2> /dev/null
        source /usr/share/fzf/key-bindings.zsh
    else
        [[ $- == *i* ]] && source ~/.local/share/fzf/shell/completion.zsh 2> /dev/null
        source ~/.local/share/fzf/shell/key-bindings.zsh
    fi
else
    git clone --depth=1 https://github.com/junegunn/fzf.git ~/.local/share/fzf
    ~/.local/share/fzf/install --no-bash --no-fish --no-key-bindings --no-completion --no-update-rc --bin
    ln -s ~/.local/share/fzf/bin/fzf ~/.local/bin/fzf
    echo "fzf will be available for next shell instance"
fi

# prompt
if [[ $TTY =~ "/dev/tty" ]]; then
    autoload -Uz promptinit && promptinit
    prompt redhat
else
    # left prompts
    if [[ -z "$SSH_CONNECTION" ]]; then
        POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir vcs)
        POWERLEVEL9K_USER_DEFAULT_BACKGROUND='232'
        POWERLEVEL9K_USER_DEFAULT_FOREGROUND='250'
        POWERLEVEL9K_USER_ROOT_BACKGROUND='250'
        POWERLEVEL9K_USER_ROOT_FOREGROUND='232'
    else
        POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(host dir vcs)
        POWERLEVEL9K_HOST_BACKGROUND='232'
        POWERLEVEL9K_HOST_FOREGROUND='250'
        POWERLEVEL9K_SSH_ICON="\uF489"
    fi
    # left colors
    # use some custom grey instead of black to avoid transparency
    POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='045'
    POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='000'
    POWERLEVEL9K_DIR_ETC_BACKGROUND='045'
    POWERLEVEL9K_DIR_ETC_FOREGROUND='000'
    POWERLEVEL9K_DIR_HOME_BACKGROUND='039'
    POWERLEVEL9K_DIR_HOME_FOREGROUND='000'
    POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='039'
    POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='000'
    # right prompts
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vi_mode status root_indicator dir_writable)
    # right colors
    POWERLEVEL9K_STATUS_OK_BACKGROUND='232'
    POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='232'
    POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='250'
    POWERLEVEL9K_VI_MODE_VISUAL_BACKGROUND='232'
    POWERLEVEL9K_VI_MODE_VISUAL_FOREGROUND='250'
    # only show error status
    POWERLEVEL9K_STATUS_OK=false
    # Vim mode indecator
    POWERLEVEL9K_VI_INSERT_MODE_STRING=''
    POWERLEVEL9K_VI_COMMAND_MODE_STRING='N'
    #POWERLEVEL9K_VI_VISUAL_MODE_STRING='V' #visual mode does not exist(?)
    # shorten the directory path TODO: fix this
    POWERLEVEL9K_SHORTEN_DIR_LENTH=1
    POWERLEVEL9K_SHORTEN_DELIMITER=""
    POWERLEVEL9K_SHORTEN_STRATEGY="truncate_to_last"
    if [[ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]]; then
        source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
    else
        if [[ ! -f ~/.local/share/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme ]]; then
            [[ ! -d ~/.local/share/zsh/plugins ]] && mkdir -p ~/.local/share/zsh/plugins
            git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.local/share/zsh/plugins/powerlevel10k
        fi
        source ~/.local/share/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
    fi

    # sudo pacman -S zsh-completions zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search
    ZSH_AUTOSUGGEST_STRATEGY=(completion history)
    ZSH_AUTOSUGGEST_USE_ASYNC=1
    ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
    autoload autosuggest-accept
    zle -N autosuggest-accept

    function check_plugin() {
        if [[ -f /usr/share/zsh/plugins/"$1"/"$1".zsh ]]; then
            source /usr/share/zsh/plugins/"$1"/"$1".zsh
        else
            if [[ ! -f ~/.local/share/zsh/plugins/"$1"/"$1".zsh ]]; then
                [[ ! -d ~/.local/share/zsh/plugins ]] && mkdir -p ~/.local/share/zsh/plugins
                git clone --depth=1 https://github.com/zsh-users/"$1".git ~/.local/share/zsh/plugins/"$1"
            fi
            source ~/.local/share/zsh/plugins/"$1"/"$1".zsh
        fi
    }

    check_plugin zsh-syntax-highlighting
    check_plugin zsh-autosuggestions
    check_plugin zsh-history-substring-search

    unset -f check_plugin
fi

#----------------------------------------------------------------------------------------------------
# keybinding settings
#----------------------------------------------------------------------------------------------------
bindkey -v
bindkey '^ ' autosuggest-accept
# Use vim keys for select when autocomplete
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
# Use vim keys for history search
zle -N history-substring-search-up
zle -N history-substring-search-down
# bindkey "$terminfo[kcuu1]" history-substring-search-up
# bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"      beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"       end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"    overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"    delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"        up-line-or-beginning-search
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"      down-line-or-beginning-search
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"      backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"     forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"    beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"  end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete

key[SEnter]=OM # manually setup since terminfo is not avaliable
[[ -n "${key[SEnter]}"   ]] && bindkey "${key[SEnter]}"          accept-and-hold
[[ -n "${key[SEnter]}"   ]] && bindkey -M vicmd "${key[SEnter]}" accept-and-hold

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
    autoload -Uz add-zle-hook-widget
    function zle_application_mode_start { echoti smkx }
    function zle_application_mode_stop { echoti rmkx }
    add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
    add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

#----------------------------------------------------------------------------------------------------
# alias
#----------------------------------------------------------------------------------------------------

alias -g ..='..'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

alias ls='ls --color=auto'
alias l='ls -lFh'
alias la='ls -lAFh'
alias lr='ls -tRFh'

alias ra='ranger'
alias rf='rifle'
alias nf='neofetch'
alias sl='ls'
alias py='python'
alias a='aria2c'
alias svim='nvim --clean'
alias pc='proxychains'
# convert encoding: echo 'xxx' | conv
# convmv -r -f gb18030 -t utf-8 <file>
alias conv='iconv -f gb18030 -t utf-8'

alias start='sudo systemctl start'
alias stop='sudo systemctl stop'
alias restart='sudo systemctl restart'
alias status='systemctl status'
alias enable='sudo systemctl enable'
alias disable='sudo systemctl disable'
alias reload='sudo systemctl reload'

alias cpr='rsync --archive -hh --partial --info=stats1 --info=progress2 --modify-window=1'
alias mvr='rsync --archive -hh --partial --info=stats1 --info=progress2 --modify-window=1 --remove-source-files'

alias wget='wget --hsts-file="~/.cache/wget-hsts"'

alias Ss='pacman -Ss'
alias Si='pacman -Si'
alias Qs='pacman -Qs'
alias Qi='pacman -Qi'
alias Ql='pacman -Ql'
alias Qo='pacman -Qo'
alias Qe='pacman -Qe'
alias Qdt='pacman -Qdt'
alias Qdtq='pacman -Qdtq'
alias Fl='pacman -Fl'
alias Fx='pacman -Fx'
alias G='paru -G'

alias S='sudo pacman -S'
alias Syu='sudo pacman -Syu'
alias R='sudo pacman -R'
alias Rns='sudo pacman -Rns'
alias Fy='sudo pacman -Fy'

alias syu='paru -Syu'
alias makepkg_native='makepkg --config ~/dotfile/PKGBUILD/makepkg_native.conf'

# alias reboot2win='sudo grub-reboot 2 && reboot'
alias rbt2firm='systemctl reboot --firmware-setup'
alias rbt2win='systemctl reboot --boot-loader-entry=auto-windows'
alias startVirtualCam='sudo modprobe v4l2loopback devices=1 video_nr=10 card_label="OBS Cam" exclusive_caps=1'
alias fixkeymap='setxkbmap -option caps:escape_shifted_capslock'
alias igtop='sudo intel_gpu_top'

alias printarg='python -c "print(__import__(\"sys\").argv[1:])"'

alias grep='grep --color=auto'

alias se='sudoedit'
# enable appended alias
alias sudo='sudo '

# plugins
eval $(thefuck --alias)
eval bindkey '^R' fzf-history-widget

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
# vi-mode
#----------------------------------------------------------------------------------------------------
# Updates editor information when the keymap changes.
function zle-keymap-select() {
    # update keymap variable for the prompt
    VI_KEYMAP=$KEYMAP

    zle reset-prompt
    zle -R
}

zle -N zle-keymap-select

function vi-accept-line() {
    VI_KEYMAP=main
    zle accept-line
}

zle -N vi-accept-line


bindkey -v

# use custom accept-line widget to update $VI_KEYMAP
bindkey -M vicmd '^J' vi-accept-line
bindkey -M vicmd '^M' vi-accept-line

# allow v to edit the command line (standard behaviour)
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line

# allow ctrl-p, ctrl-n for navigate history (standard behaviour)
bindkey '^P' up-history
bindkey '^N' down-history

# allow ctrl-h, ctrl-w, ctrl-? for char and word deletion (standard behaviour)
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

# allow ctrl-a and ctrl-e to move to beginning/end of line
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# if mode indicator wasn't setup by theme, define default
if [[ "$MODE_INDICATOR" == "" ]]; then
    MODE_INDICATOR="%{$fg_bold[red]%}<%{$fg[red]%}<<%{$reset_color%}"
fi

# define right prompt, if it wasn't defined by a theme
# somehow only works from second prompt
if [[ $TTY =~ "/dev/tty" ]]; then
    if [[ "$RPS1" == "" && "$RPROMPT" == "" ]]; then
        function zle-line-init zle-keymap-select {
            RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
            RPS2=$RPS1
            zle reset-prompt
        }
        zle -N zle-line-init
        zle -N zle-keymap-select
    fi
fi

#----------------------------------------------------------------------------------------------------
# Fancy Ctrl Z
#----------------------------------------------------------------------------------------------------

fancy-ctrl-z () {
if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
else
    zle push-input -w
    zle clear-screen -w
fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z


#----------------------------------------------------------------------------------------------------
# sudo command line
#----------------------------------------------------------------------------------------------------
# sudo-command-line() {
#     [[ -z $BUFFER ]] && zle up-history
#     [[ $BUFFER != sudo\ * && $UID -ne 0 ]] && {
#       typeset -a bufs
#       bufs=(${(z)BUFFER})
#       while (( $+aliases[$bufs[1]] )); do
#         local expanded=(${(z)aliases[$bufs[1]]})
#         bufs[1,1]=($expanded)
#         if [[ $bufs[1] == $expanded[1] ]]; then
#           break
#         fi
#       done
#       bufs=(sudo $bufs)
#       BUFFER=$bufs
#     }
#     zle end-of-line
# }
# zle -N sudo-command-line
# bindkey "\e\e" sudo-command-line

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
