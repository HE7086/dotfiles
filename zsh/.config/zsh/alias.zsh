#----------------------------------------------------------------------------------------------------
# alias
#----------------------------------------------------------------------------------------------------

alias -g ..='..'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

if command -v eza > /dev/null; then
    alias ls='eza'
    alias l='eza -lgF'
    alias ll='eza -lagH@F'
    alias la='eza -lagF'
    alias laa='eza -laagF'
    alias lr='eza -TF'
else
    alias ls='ls --color=auto'
    alias l='ls --color=auto -lh'
    alias la='ls --color=auto -lah'
fi

# alias ra='ranger'
alias sl='ls'
alias py='python'
alias a='aria2c'
alias svim='nvim --clean'
alias vim='nvim'
alias pc='proxychains'
alias tm='tmux -2'
alias tf='tofu'

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
alias ip='ip --color=auto'

if command -v pacman > /dev/null; then
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

    # alias F='pacman -F'
    # alias Fl='pacman -Fl'
    # alias Fx='pacman -Fx'
    # alias Fy='sudo pacman -Fy'
    alias F='pacfiles'
    alias Fl='pacfiles -l'
    alias Fx='pacfiles -x'
    alias Fy='sudo pacfiles -y'

    alias G='paru -G'

    alias S='sudo pacman -S'
    alias Sa='paru -Sa'
    alias Syu='sudo pacman -Syu'
    alias R='sudo pacman -R'
    alias Rns='sudo pacman -Rns'

    alias syu='paru -Syu'

fi

alias rbt2firm='systemctl reboot --firmware-setup'
function rbt2win() {
    if [[ -f /usr/bin/grub-reboot ]]; then
        sudo grub-reboot "$(grep -i windows /boot/grub/grub.cfg|cut -d"'" -f2)" 
        sudo reboot
    else
        sudo systemctl reboot --boot-loader-entry=auto-windows
    fi

}
# alias fixkeymap='setxkbmap -option caps:escape_shifted_capslock'
alias igtop='sudo intel_gpu_top'

alias printarg='python3 -c "print(__import__(\"sys\").argv[1:])"'
alias unquote='python3 -c "import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()));"'

alias grep='grep --color=auto'

alias se='sudoedit'
# enable appended alias
alias sudo='sudo '

alias power='cat /sys/firmware/acpi/platform_profile'
alias j='just'
alias hm='home-manager'

alias venv='python -m venv'
alias venvact='source ~/data/venv/bin/activate'

# alias ssh_nh='ssh -o StrictHostKeyChecking=no'
alias cbuild='cmake -B build -G "Ninja Multi-Config" && cmake --build build'
