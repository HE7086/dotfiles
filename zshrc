# Path to your oh-my-zsh installation.
export ZSH="$HOME/.config/oh-my-zsh"

# auto install for first time
if [ ! -e $ZSH/oh-my-zsh.sh ]
then
    curl -Lo ~/omz_install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
    chmod +x ~/omz_install.sh
    ZSH=$ZSH ~/omz_install.sh --unattended
    export ZSH_CUSTOM="$HOME/.config/oh-my-zsh/custom"
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM}/plugins/zsh-completions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
    git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k
    git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM}/plugins/zsh-history-substring-search
    rm -f ~/omz_install.sh
    rm -f ~/.zshrc
    mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
fi


autoload -U colors && colors

zstyle ':completion:*' menu select
zmodload zsh/complist

# Use vim keys in tab complete menu
bindkey -v
export KEYTIMEOUT=1

#------------------------------------------------
# Theme settings
#------------------------------------------------
# ZSH_THEME="powerlevel9k/powerlevel9k"
if [[ -z "$TMUX" ]]
then
    ZSH_THEME="powerlevel10k/powerlevel10k"
else
    ZSH_THEME="robbyrussell"
fi
# left prompts
if [[ -z "$SSH_CONNECTION" ]]
then
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

#------------------------------------------------
# other settings
#------------------------------------------------
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"
# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"
# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

#------------------------------------------------
# plugin settings
#------------------------------------------------
ZSH_AUTOSUGGEST_STRATEGY=(completion history)
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
autoload autosuggest-accept
zle -N autosuggest-accept
bindkey '^ ' autosuggest-accept

HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

plugins=(
    lol
    vi-mode
    fancy-ctrl-z
    zsh-completions
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-history-substring-search
)

autoload -U compinit 
compinit

source $ZSH/oh-my-zsh.sh

# User configuration
export LANG=en_US.UTF-8
export EDITOR=/usr/bin/nvim

#------------------------------------------------
# Aliases
#------------------------------------------------
alias vim='nvim'
alias vi='nvim'
alias ra='ranger'
alias nf='neofetch'
alias py='python3'
alias sctl='sudo systemctl '

# make sure to leave a space at the end to enable appended aliases
alias sudo='SUDO '
# wenn using sudo root, preserve the variables
function SUDO() {
   case $1 in 
       vi|vim|nvim) command sudo -E "$@";;
       *) command sudo "$@";;
   esac
}


# # prevent nested ranger -- cause inf. loop?
# ranger() {
#     if [[ -z "$RANGER_LEVEL" ]]
#     then
#         /usr/bin/ranger "$@"
#     else
#         exit
#     fi
# }
    
# # ex - archive extractor
ex () {
    if [[ $# -eq 0 ]] ; then
        echo "ex: archive extractor"
        echo "usage: ex <file>"
    fi
    while [[ -n "$1" ]] ; do
        if [[ -f $1 ]] ; then
            case $1 in    
                *.tar.bz2)   tar xjf $1   ;;
                *.tar.gz)    tar xzf $1   ;;
                *.bz2)       bunzip2 $1   ;;
                *.rar)       unrar x $1   ;;
                *.gz)        gunzip $1    ;;
                *.tar)       tar xf $1    ;;
                *.tbz2)      tar xjf $1   ;;
                *.tgz)       tar xzf $1   ;;
                *.zip)       unzip $1     ;;
                *.Z)         uncompress $1;;
                *.7z)        7z x $1      ;;
                *)           echo "'$1' cannot be extracted via ex()" ;;
            esac
        else
            echo "'$1' is not a valid file"
        fi
        shift
    done
}


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval $(thefuck --alias)
#------------------------------------------------
# Key bindings
#------------------------------------------------
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

#------------------------------------------------
# key stroke workaround for vi mode
#------------------------------------------------
# https://wiki.parabola.nu/Zsh
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key
key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}
# setup key accordingly
# key bindings in insert mode
[[ -n "${key[Home]}"     ]] && bindkey "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]] && bindkey "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]] && bindkey "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]] && bindkey "${key[Delete]}"   delete-char
[[ -n "${key[PageUp]}"   ]] && bindkey "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]] && bindkey "${key[PageDown]}" end-of-buffer-or-history
# key bindings in normal mode
[[ -n "${key[Home]}"     ]] && bindkey -M vicmd "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]] && bindkey -M vicmd "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]] && bindkey -M vicmd "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]] && bindkey -M vicmd "${key[Delete]}"   delete-char
[[ -n "${key[PageUp]}"   ]] && bindkey -M vicmd "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]] && bindkey -M vicmd "${key[PageDown]}" end-of-buffer-or-history
# shifted enter does not work well in insert mode which insert a M
key[SEnter]=OM # manually setup since terminfo is not avaliable
[[ -n "${key[SEnter]}"   ]] && bindkey "${key[SEnter]}"     accept-line
[[ -n "${key[SEnter]}"   ]] && bindkey -M vicmd "${key[SEnter]}"     accept-line


[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"
