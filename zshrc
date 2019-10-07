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
    git clone https://github.com/bhilburn/powerlevel9k.git ${ZSH_CUSTOM}/themes/powerlevel9k
    rm -f ~/omz_install.sh
fi




autoload -U colors && colors

zstyle ':completion:*' menu select
zmodload zsh/complist

# Use vim keys in tab complete menu
bindkey -v
export KEYTIMEOUT=1
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

#------------------------------------------------
# Theme settings
#------------------------------------------------
ZSH_THEME="powerlevel9k/powerlevel9k"
# left prompts
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir vcs)
# left colors
# use some custom grey instead of black to avoid transparency
POWERLEVEL9K_USER_DEFAULT_BACKGROUND='232'
POWERLEVEL9K_USER_DEFAULT_FOREGROUND='250'
POWERLEVEL9K_USER_ROOT_BACKGROUND='250'
POWERLEVEL9K_USER_ROOT_FOREGROUND='232'
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
POWERLEVEL9K_SHORTEN_DIR_LENTH=2
POWERLEVEL9K_DIR_SHORTEN_LENTH=2 # ?
POWERLEVEL9K_SHORTEN_DELIMITER='.'
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique #this does not work 
#POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right" #does this work?

#------------------------------------------------
# other settings
#------------------------------------------------
# Uncomment the following line to use hyphen-insensitive completion.
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
# ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
autoload autosuggest-accept
zle -N autosuggest-accept
bindkey '^ ' autosuggest-accept

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse zsh-syntax-highlighting)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    vi-mode
    fancy-ctrl-z
    zsh-completions
    zsh-autosuggestions
    zsh-syntax-highlighting
)

autoload -U compinit 
compinit

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
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


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
