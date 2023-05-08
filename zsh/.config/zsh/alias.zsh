#----------------------------------------------------------------------------------------------------
# alias
#----------------------------------------------------------------------------------------------------

alias -g ..='..'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

alias ls='exa'
alias l='exa -lgF'
alias ll='exa -lagFH@'
alias la='exa -lagF'
alias laa='exa -laagF'
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

alias status='systemctl status'
alias ustatus='systemctl --user status'

alias ustart='systemctl --user start'
alias ustop='systemctl --user stop'
alias urestart='systemctl --user restart'
alias uenable='systemctl --user enable'
alias udisable='systemctl --user disable'
alias ureload='systemctl --user reload'

alias start='sudo systemctl start'
alias stop='sudo systemctl stop'
alias restart='sudo systemctl restart'
alias enable='sudo systemctl enable'
alias disable='sudo systemctl disable'
alias reload='sudo systemctl reload'
alias dreload='sudo systemctl daemon-reload'

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
alias F='pacman -F'
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

# alias reboot2win='sudo grub-reboot 2 && reboot'
alias rbt2firm='systemctl reboot --firmware-setup'
# alias rbt2win='systemctl reboot --boot-loader-entry=auto-windows'
function rbt2win() {
    if [[ -f /usr/bin/grub-reboot ]]; then
        sudo grub-reboot "$(grep -i windows /boot/grub/grub.cfg|cut -d"'" -f2)" 
        reboot
    else
        systemctl reboot --boot-loader-entry=auto-windows
    fi

}
alias fixkeymap='setxkbmap -option caps:escape_shifted_capslock'
alias igtop='sudo intel_gpu_top'

alias printarg='python -c "print(__import__(\"sys\").argv[1:])"'

alias grep='grep --color=auto'

alias se='sudoedit'
# enable appended alias
alias sudo='sudo '

alias d='dir -v'
alias power='cat /sys/firmware/acpi/platform_profile'
