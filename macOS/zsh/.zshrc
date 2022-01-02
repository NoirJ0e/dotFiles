



# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# alias

alias cd="z"
alias ls="exa --icons"
alias REPO="cd ~/Repos"
alias py3="python3"
alias cc="clear"
alias pluginstall='source ~/.zshrc && zplug install && zsh && zplug load'
alias vi="nvim"
alias vim="nvim"
alias ra="ranger"
alias backup="brew bundle dump --describe --force --file="~/Documents/Brewfile""
alias tree="tree -N"
# 防止 copy 的时候覆盖已存在的文件, 带上 i 选项，文件已存在的时候，会提示，需要确认才能 copy
# alias cp="cp -I"
# 把rm变成放进回收站
alias rm="trash"
# Spotify
alias spp="spotify pause"
alias sps="spotify play"
alias zip='zip -r -9'


# start zplug (from homebrew)
eval $(thefuck --alias)
export ZPLUG_HOME=$(brew --prefix)/opt/zplug
source $ZPLUG_HOME/init.zsh
# zplug plugs
zplug "zsh-users/zsh-autosuggestions"
zplug "zdharma-continuum/fast-syntax-highlighting"
# configuration framework
zplug "sorin-ionescu/prezto"
# zsh-vi-mode
#zplug "jeffreytse/zsh-vi-mode"
# colorful ls results
zplug "zpm-zsh/ls"
# better completion
zplug "zsh-users/zsh-completions"
# fzf zsh
zplug "unixorn/fzf-zsh-plugin"
# p10k theme
zplug romkatv/powerlevel10k, as:theme, depth:1
# extract 
zplug "plugins/extract",   from:oh-my-zsh
# sudo
zplug "plugins/sudo",   from:oh-my-zsh
# osx controls
# zplug "plugins/macos",   from:oh-my-zsh

# Share history from multiple zsh instances

HISTFILE=/Users/noirjoe/.zshrc-history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Sources

# fzf
source /usr/local/opt/fzf/shell/key-bindings.zsh
source /usr/local/opt/fzf/shell/completion.zsh
#export FZF_DEFAULT_COMMAND='if [ -f cscope.files ]; then cat cscope.files; else find ./ -type f ; fi'
export FZF_COMPLETION_TRIGGER='\'
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# Startup commands 
zplug load
# exports
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export EDITOR="nvim"
export PATH="/usr/local/opt/curl/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/curl/lib"
export CPPFLAGS="-I/usr/local/opt/curl/include"
export PKG_CONFIG_PATH="/usr/local/opt/curl/lib/pkgconfig"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PATH="/usr/local/opt/qt@5/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/qt@5/lib"
export CPPFLAGS="-I/usr/local/opt/qt@5/include"
export PKG_CONFIG_PATH="/usr/local/opt/qt@5/lib/pkgconfig"
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export CXX=/usr/local/bin/clang++
# prompt
autoload -U promptinit; promptinit
# tab completion case-insensitive
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
# starup
#tmux
#typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
eval "$(zoxide init zsh)"
