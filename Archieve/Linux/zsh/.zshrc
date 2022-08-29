# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# exports
export LANG=en_US.UTF-8
export EDITOR="nvim"

# tab completion case-insensitive
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# keep history
HISTFILE=/home/noir/.zsh-history
HISTSIZE=200
SAVEHIST=200
setopt appendhistory
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# alias
alias reboot="systemctl reboot"
alias sus="systemctl suspend"
alias reb="systemctl reboot"
alias cat="bat"
alias fg="git add . ; git commit -m 'Update on Arch' ; git push origin master"
alias ls="exa --icons"
alias cd="z"
alias REPO="cd ~/Repos"
alias py3="python3"
alias cc="clear"
alias vi="nvim"
alias vim="nvim"
alias ra="ranger"
alias tree="tree -N"
alias rm="trash"

# fzf
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FZF_COMPLETION_TRIGGER='\'
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
#
# Plugins

# start instantly
zinit light zsh-users/zsh-autosuggestions
zinit ice wait"1" lucid
zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice wait"1" lucid
zinit light zpm-zsh/ls

zinit ice depth"1" # git clone depth
zinit light romkatv/powerlevel10k

zinit ice wait"2" lucid
zinit light hcgraf/zsh-sudo
zinit ice wait"5" lucid
zinit light thetic/extract
zinit light jeffreytse/zsh-vi-mode

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# start zoxide
eval "$(zoxide init zsh)"
