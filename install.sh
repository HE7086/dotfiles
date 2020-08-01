#! /bin/bash

mkdir $PWD/backup

[[ -z $XDG_CONFIG_HOME ]] && XDG_CONFIG_HOME=$HOME/.config

# $1 : the file to be linked 
# $2 : the linking path 
# $3 : the linking file
backup() {
    if [ -e $2/$3 ]
    then
        echo "$2/$3 already exists! backup in backup directory"
        mv $2/$3 $PWD/backup/ # may need to parse sudo
    else
        mkdir -p $2
    fi
    ln -s $PWD/$1 $2/$3
}

[[ -z $ZDOTDIR ]] && ZDOTDIR=$XDG_CONFIG_HOME/zsh
backup zsh/zshrc $ZDOTDIR .zshrc
backup zsh/zshenv $ZDOTDIR .zshenv
backup zsh/fzf.zsh $ZDOTDIR fzf.zsh

backup gitconfig $XDG_CONFIG_HOME/git config
backup pam_environment ~ .pam_environment
backup idea.vimrc $XDG_CONFIG_HOME/ideavim .ideavimrc
backup neo.vimrc $XDG_CONFIG_HOME/nvim init.vim
backup ranger.conf $XDG_CONFIG_HOME/ranger rc.conf
backup vscode.json $XDG_CONFIG_HOME/Code/User settings.json
backup vscodeKey.json $XDG_CONFIG_HOME/Code/User keybindings.json
backup kitty.conf $XDG_CONFIG_HOME/kitty kitty.conf

echo 'dot file linking complete!'
