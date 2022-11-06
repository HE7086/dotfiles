# setup cache directory if not exist
[[ -d ~/.cache/zsh ]] || mkdir -p ~/.cache/zsh;

export MANPAGER='sh -c "col -bx | bat -pl man"'
export MANROFFOPT='-c'

#----------------------------------------------------------------------------------------------------
# completion settings
#----------------------------------------------------------------------------------------------------
autoload -Uz compinit && compinit -d ~/.cache/zsh/zcompdump
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
zstyle ':completion:*' cache-path ~/.cache/zsh/zcompcache

# cd options
setopt autocd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_minus

setopt interactive_comments
setopt auto_continue
# setopt extended_glob
# setopt no_bare_glob_qual
setopt listpacked
setopt magic_equal_subst

# rm option
setopt rm_star_silent

#----------------------------------------------------------------------------------------------------
# history settings
#----------------------------------------------------------------------------------------------------
HISTORY_IGNORE="(ls|l|ll|cd|pwd|exit|vim|.|..|...)"
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/zsh_history
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
    [[ -d ~/.local/bin ]] || mkdir -p ~/.local/bin
    [[ -d ~/.local/share ]] || mkdir -p ~/.local/share
    git clone --depth=1 https://github.com/junegunn/fzf.git ~/.local/share/fzf
    ~/.local/share/fzf/install --no-bash --no-fish --no-key-bindings --no-completion --no-update-rc --bin
    ln -s ~/.local/share/fzf/bin/fzf ~/.local/bin/fzf
    echo "fzf will be available for next shell instance"
fi
eval bindkey '^R' fzf-history-widget

# prompt
if [[ $TTY =~ "/dev/tty" ]]; then
    # only show right prompt on newest line
    setopt transient_rprompt

    autoload -Uz promptinit && promptinit
    prompt redhat
else
    export PROMPT_EOL_MARK=$'\u23CE'

    #========================================
    # powerlevel10k configs
    #========================================

    typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true 
    typeset -g POWERLEVEL9K_INSTANE_PROMPT=quiet

    typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR=$'-'
    # typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_BACKGROUND='000'
    typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_FOREGROUND='240'

    # left prompts ====================
    if [[ -z "$SSH_CONNECTION" ]]; then
        typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
            user
            dir
            vcs
            command_execution_time
            newline
            prompt_char
        )
        typeset -g POWERLEVEL9K_USER_DEFAULT_BACKGROUND='232'
        typeset -g POWERLEVEL9K_USER_DEFAULT_FOREGROUND='250'
        typeset -g POWERLEVEL9K_USER_ROOT_BACKGROUND='250'
        typeset -g POWERLEVEL9K_USER_ROOT_FOREGROUND='232'
    else
        typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
            context
            dir
            vcs
            command_execution_time
            newline
            prompt_char
        )
        typeset -g POWERLEVEL9K_CONTEXT_BACKGROUND='232'
        typeset -g POWERLEVEL9K_CONTEXT_FOREGROUND='250'
        typeset -g POWERLEVEL9K_SSH_ICON="\uF489"
    fi

    # dir
    typeset -g POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='045'
    typeset -g POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='000'
    typeset -g POWERLEVEL9K_DIR_ETC_BACKGROUND='045'
    typeset -g POWERLEVEL9K_DIR_ETC_FOREGROUND='000'
    typeset -g POWERLEVEL9K_DIR_HOME_BACKGROUND='039'
    typeset -g POWERLEVEL9K_DIR_HOME_FOREGROUND='000'
    typeset -g POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='039'
    typeset -g POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='000'
    # shorten the directory path TODO: fix this
    # typeset -g POWERLEVEL9K_SHORTEN_DIR_LENTH=1
    # typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=""
    # typeset -g POWERLEVEL9K_SHORTEN_STRATEGY="truncate_to_last"
    typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=v3

    # vcs
    typeset -g POWERLEVEL9K_VCS_MAX_SYNC_LATENCY_SECONDS=0.003
    typeset -g POWERLEVEL9K_VCS_BACKENDS=(git)

    # command execution time
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='000'
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='231'
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_VISUAL_IDENTIFIER_EXPANSION=$'\uf43a'

    # prompt char
    typeset -g POWERLEVEL9K_LEFT_SEGMENT_END_SEPARATOR=''
    typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=''
    typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=''
    typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_LEFT_WHITESPACE=''
    typeset -g POWERLEVEL9K_PROMPT_CHAR_BACKGROUND='000'

    # right prompts ====================
    typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
        background_jobs
        vi_mode 
        status 
        root_indicator 
        dir_writable 
        time
    )
    export ZLE_RPROMPT_INDENT=0

    # background jobs
    typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=true
    typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VISUAL_IDENTIFIER_EXPANSION=$'\uf444'

    # Vim mode indecator
    typeset -g POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='232'
    typeset -g POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='250'
    typeset -g POWERLEVEL9K_VI_MODE_VISUAL_BACKGROUND='232'
    typeset -g POWERLEVEL9K_VI_MODE_VISUAL_FOREGROUND='250'
    typeset -g POWERLEVEL9K_TIME_BACKGROUND='232'
    typeset -g POWERLEVEL9K_TIME_FOREGROUND='250'
    typeset -g POWERLEVEL9K_VI_INSERT_MODE_STRING=''
    typeset -g POWERLEVEL9K_VI_COMMAND_MODE_STRING='N'
    #POWERLEVEL9K_VI_VISUAL_MODE_STRING='V' #visual mode does not exist(?)

    # status
    typeset -g POWERLEVEL9K_STATUS_OK=false
    typeset -g POWERLEVEL9K_STATUS_OK_PIPE=true
    typeset -g POWERLEVEL9K_STATUS_OK_BACKGROUND='232'
    typeset -g POWERLEVEL9K_STATUS_ERROR=true
    typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL=true
    typeset -g POWERLEVEL9K_STATUS_VERBOSE_SIGNAME=true
    typeset -g POWERLEVEL9K_STATUS_ERROR_VISUAL_IDENTIFIER_EXPANSION=$'\u2718'
    typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE=true
    typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_VISUAL_IDENTIFIER_EXPANSION=$'\u2718'

    # auto install powerlevel10k
    if [[ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]]; then
        source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
    else
        if [[ ! -f ~/.local/share/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme ]]; then
            [[ -d ~/.local/share/zsh/plugins ]] || mkdir -p ~/.local/share/zsh/plugins
            git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.local/share/zsh/plugins/powerlevel10k
        fi
        source ~/.local/share/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
    fi

    #========================================
    # prompt extensions
    #========================================
    # sudo pacman -S zsh-completions zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search
    ZSH_AUTOSUGGEST_STRATEGY=(completion history)
    ZSH_AUTOSUGGEST_USE_ASYNC=1
    ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
    ZSH_AUTOSUGGEST_MANUAL_REBIND=1
    autoload autosuggest-accept
    zle -N autosuggest-accept

    HISTORY_SUBSTRING_SEARCH_FUZZY=1

    function check_plugin() {
        if [[ -f /usr/share/zsh/plugins/"$2"/"$3".zsh ]]; then
            source /usr/share/zsh/plugins/"$2"/"$3".zsh
        else
            if [[ ! -d ~/.local/share/zsh/plugins/"$2" ]]; then
                [[ -d ~/.local/share/zsh/plugins ]] || mkdir -p ~/.local/share/zsh/plugins
                git clone --depth=1 https://github.com/"$1"/"$2".git ~/.local/share/zsh/plugins/"$2"
            fi
            source ~/.local/share/zsh/plugins/"$2"/"$3".zsh
        fi
    }

    # check_plugin zsh-users zsh-syntax-highlighting
    check_plugin zsh-users zsh-autosuggestions zsh-autosuggestions
    check_plugin zsh-users zsh-history-substring-search zsh-history-substring-search

    # check_plugin z-shell zsh-fast-syntax-highlighting fast-syntax-highlighting.plugin
    # check_plugin z-shell F-Sy-H F-Sy-H.plugin

    unset -f check_plugin

    # auto install fast syntax highlighting
    if [[ -f /usr/share/zsh/plugins/zsh-fast-syntax-highlighting/F-Sy-H.plugin.zsh ]]; then
        source /usr/share/zsh/plugins/zsh-fast-syntax-highlighting/F-Sy-H.plugin.zsh
    else
        if [[ ! -f ~/.local/share/zsh/plugins/F-Sy-H/F-Sy-H.plugin.zsh ]]; then
            [[ -d ~/.local/share/zsh/plugins ]] || mkdir -p ~/.local/share/zsh/plugins
            git clone --depth=1 https://github.com/z-shell/F-Sy-H.git ~/.local/share/zsh/plugins/F-Sy-H
        fi
        source ~/.local/share/zsh/plugins/F-Sy-H/F-Sy-H.plugin.zsh
    fi
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

bindkey ' ' magic-space
bindkey '^Q' push-line

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

# key[SEnter]=OM # manually setup since terminfo is not avaliable
# [[ -n "${key[SEnter]}"   ]] && bindkey "${key[SEnter]}"          accept-and-hold
# [[ -n "${key[SEnter]}"   ]] && bindkey -M vicmd "${key[SEnter]}" accept-and-hold

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
# color hacks for alacritty
#----------------------------------------------------------------------------------------------------

if [ "$TERM" = "alacritty" -a -z "$COLORTERM" ]; then
    export COLORTERM=truecolor
    # eval $(env TERM=xterm-256color dircolors)
    # export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.swp=00;90:*.tmp=00;90:*.dpkg-dist=00;90:*.dpkg-old=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:';
fi

#----------------------------------------------------------------------------------------------------
# alias
#----------------------------------------------------------------------------------------------------

alias -g ..='..'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

alias ls='exa'
alias l='exa -lF'
alias ll='exa -laFH@'
alias la='exa -laF'
alias laa='exa -laaF'
alias lr='exa -TF'

alias ra='ranger'
alias rf='rifle'
alias nf='neofetch'
alias sl='ls'
alias py='python'
alias a='aria2c'
alias svim='nvim --clean'
alias vim=nvim
alias pc='proxychains'
alias nv='neovide'
alias tm='tmux -2'
# convert encoding: echo 'xxx' | conv
# convmv -r -f gb18030 -t utf-8 <file>
# alias conv='iconv -f gb18030 -t utf-8'

alias maek='make'

alias start='sudo systemctl start'
alias stop='sudo systemctl stop'
alias restart='sudo systemctl restart'
alias status='systemctl status'
alias enable='sudo systemctl enable'
alias disable='sudo systemctl disable'
alias reload='sudo systemctl reload'

alias cpr='rsync --archive -hh --partial --info=stats1 --info=progress2 --modify-window=1'
alias mvr='rsync --archive -hh --partial --info=stats1 --info=progress2 --modify-window=1 --remove-source-files'
alias bkup='rsync --archive -hh --partial --info=stats1 --info=progress2 --modify-window=1 --delete'

alias wget='wget --hsts-file="~/.cache/wget-hsts"'

alias Ss='pacman -Ss'
alias Si='pacman -Si'
alias Ssa='paru -Ssa'
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
alias Sa='paru -Sa'
alias Syu='sudo pacman -Syu'
alias R='sudo pacman -R'
alias Rns='sudo pacman -Rns'
alias Fy='sudo pacman -Fy'

alias syu='paru -Syu'
alias makepkg_native='makepkg --config ~/dotfile/PKGBUILD/makepkg_native.conf'

# alias reboot2win='sudo grub-reboot 2 && reboot'
alias rbt2firm='systemctl reboot --firmware-setup'
alias rbt2win='systemctl reboot --boot-loader-entry=auto-windows'
alias fixkeymap='setxkbmap -option caps:escape_shifted_capslock'
alias igtop='sudo intel_gpu_top'

alias printarg='python -c "print(__import__(\"sys\").argv[1:])"'

alias grep='grep --color=auto'

alias se='sudoedit'
# enable appended alias
alias sudo='sudo '

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
sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * && $UID -ne 0 ]] && {
      typeset -a bufs
      bufs=(${(z)BUFFER})
      while (( $+aliases[$bufs[1]] )); do
        local expanded=(${(z)aliases[$bufs[1]]})
        bufs[1,1]=($expanded)
        if [[ $bufs[1] == $expanded[1] ]]; then
          break
        fi
      done
      bufs=(sudo $bufs)
      BUFFER=$bufs
    }
    zle end-of-line
}
zle -N sudo-command-line
bindkey "\e\e" sudo-command-line

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
        exec startplasma-wayland
    else
        # todo: fix this
        export XDG_SESSION_TYPE=x11
        export QT_QPA_PLATFORM=xcb
        export DESKTOP_SESSION=plasma
        export DISPLAY=:1
        startplasma-x11
    fi
}


#----------------------------------------------------------------------------------------------------
# auto compile zshrc
if [[ $ZDOTDIR/.zshrc -nt $ZDOTDIR/.zshrc.zwc ]] || [[ ! -e $ZDOTDIR/.zshrc.zwc ]]; then
    zcompile -R $ZDOTDIR/.zshrc
fi
