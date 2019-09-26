#! /bin/bash

mkdir $PWD/backup

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
backup zshrc ~ .zshrc
backup gitconfig ~ .gitconfig
backup pam_environment ~ .pam_environment
backup idea.vimrc ~ .ideavimrc
backup neo.vimrc ~/.config/nvim init.vim
backup ranger.conf ~/.config/ranger rc.conf
backup vscode.json ~/.config/Code/User settings.json
backup kitty.conf ~/.config/kitty kitty.conf

echo 'dot file linking complete!'
