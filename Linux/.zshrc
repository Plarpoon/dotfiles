# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd beep extendedglob nomatch notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/plarpoon/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

# Zinit plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit light starship/starship

starship config command_timeout 10000

# Aliases
alias htop="btm --color gruvbox"
alias cat="bat --color=always"
alias ls="eza --color always"
#alias sed="sd"
alias cmake-compile="cmake -S . -B build -DCMAKE_CXX_COMPILER=clang++"
#alias grep = "rg" 
alias neofetch="fastfetch"

# Docker Trak Aliases
alias dtrak_clean="docker system prune && docker image remove docker_trak_devel:1:0 && docker system prune"
alias dtrak_run="docker run --net=host -it -p 8080:8080 --memory=8g --ulimit nofile=65536:65536 docker_trak_devel:1.0 bash"
alias dtrak_build="docker build -t docker_trak_devel:1.0 ."

# VPN
alias vpn_on="sudo wg-quick up /etc/wireguard/zcs-sviluppo.conf"
alias vpn_off="sudo wg-quick down /etc/wireguard/zcs-sviluppo.conf"
