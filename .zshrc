if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="/home/adriano.elias/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
git
virtualenv
docker
docker-compose
sudo
node
kubectl
)

POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status virtualenv)
export ZSH_DISABLE_COMPFIX=true
source $ZSH/oh-my-zsh.sh

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light-mode for \
    zdharma-continuum/zinit-annex-rust \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-bin-gem-node

### End of Zinit's installer chunk

zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

#Export
export ANSIBLE_PROVISION_PLAYBOOK=vagrant-clean.yml
export ANSIBLE_CONFIG=ansible-vagrant.cfg
export ANSIBLE_VAULT_PASSWORD_FILE=~/.config/ansible/vault_pass
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=/home/adriano.elias/.local/bin/virtualenv
export SPICETIFY_INSTALL="/home/adriano.elias/spicetify-cli"
export XDG_DATA_DIRS="/var/lib/flatpak/exports/share:$XDG_DATA_DIRS"
export BW_SESSION="fIMFe0MkgHYgJxyXX42SjDNRQMNXeV3kkTQLRml6TN4RG684zv3a531K343qd11XFP6YwO95ZB2vZnn0JzJUlQ=="

source /home/adriano.elias/.local/bin/virtualenvwrapper.sh
source ~/.config/shell/aliases
source ~/.zshenv

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
