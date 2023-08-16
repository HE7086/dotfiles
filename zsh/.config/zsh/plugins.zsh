#----------------------------------------------------------------------------------------------------
# Plugin Settings
#----------------------------------------------------------------------------------------------------

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
    typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

    typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR='-'
    # typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_BACKGROUND='000'
    typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_FOREGROUND='240'

    # left prompts ====================
    if [[ -z "$SSH_CONNECTION" ]]; then
        typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
            user
            dir
            vcs
            virtualenv
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
            virtualenv
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
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='' #'232'
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='250'
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_VISUAL_IDENTIFIER_EXPANSION=$'\uf43a'
    typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=''

    # prompt char
    typeset -g POWERLEVEL9K_LEFT_SEGMENT_END_SEPARATOR=''
    typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=''
    typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=''
    typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_LEFT_WHITESPACE=''
    typeset -g POWERLEVEL9K_PROMPT_CHAR_BACKGROUND=''

    # right prompts ====================
    typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
        nix_shell
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

    #========================================
    # prompt extensions
    #========================================
    ZSH_AUTOSUGGEST_STRATEGY=(completion history)
    ZSH_AUTOSUGGEST_USE_ASYNC=1
    ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
    ZSH_AUTOSUGGEST_MANUAL_REBIND=1
    autoload autosuggest-accept
    zle -N autosuggest-accept

    HISTORY_SUBSTRING_SEARCH_FUZZY=1


    # non-tty plugins
    auto_source ~/dotfiles/Submodules/powerlevel10k/powerlevel10k.zsh-theme

    auto_source ~/dotfiles/Submodules/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
    auto_compile ~/dotfiles/Submodules/fast-syntax-highlighting/fast-string-highlight
    auto_compile ~/dotfiles/Submodules/fast-syntax-highlighting/fast-highlight

    auto_source ~/dotfiles/Submodules/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
    auto_compile ~/dotfiles/Submodules/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
fi

# universal plugins
auto_source ~/dotfiles/Submodules/zsh-autopair/zsh-autopair.plugin.zsh
auto_compile ~/dotfiles/Submodules/zsh-autopair/autopair.zsh

auto_source ~/dotfiles/Submodules/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
auto_compile ~/dotfiles/Submodules/zsh-history-substring-search/zsh-history-substring-search.zsh

auto_source ~/dotfiles/Submodules/zsh-completions/zsh-completions.plugin.zsh

# FZF
if ! command -v fzf > /dev/null; then 
    ~/dotfiles/Submodules/fzf/install --no-bash --no-fish --no-key-bindings --no-completion --no-update-rc --bin
fi
auto_source ~/dotfiles/Submodules/fzf/shell/key-bindings.zsh
eval bindkey '^R' fzf-history-widget

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

