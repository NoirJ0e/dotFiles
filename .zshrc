# ============================================
#  ZSH Configuration
#  Optimized for performance and maintainability
# ============================================

# ============================================
#  Performance: Instant Prompt & Conditional Loading
# ============================================

# Detect OS early
export IS_MAC=false
export IS_LINUX=false
[[ "$(uname)" == "Darwin" ]] && IS_MAC=true
[[ "$(uname)" == "Linux" ]] && IS_LINUX=true

# ============================================
#  Environment Variables
# ============================================

export EDITOR=nvim
export VISUAL=nvim
export GPG_TTY=$(tty)

# FZF configuration
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"

# Linux-specific: HiDPI settings
if $IS_LINUX; then
    export QT_AUTO_SCREEN_SCALE_FACTOR=1
    export QT_ENABLE_HIGHDPI_SCALING=1
    export QT_SCALE_FACTOR=2
    export GDK_SCALE=2
fi

# ============================================
#  Path Configuration
# ============================================

# Build PATH array (deduplicated automatically by typeset -U)
typeset -U path
path=(
    $HOME/.cargo/bin
    $HOME/go/bin
    $HOME/.console-ninja/.bin
    $HOME/.bun/bin
    $HOME/Library/pnpm              # pnpm (Mac)
    /opt/homebrew/opt/postgresql@17/bin
    /opt/homebrew/opt/rustup/bin
    $path
)
export PATH

# PNPM Home
export PNPM_HOME="$HOME/Library/pnpm"
export BUN_INSTALL="$HOME/.bun"
export SDKMAN_DIR="$HOME/.sdkman"

# ============================================
#  Plugin Manager: Zinit
# ============================================

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Install Zinit if not present
if [[ ! -d $ZINIT_HOME ]]; then
    print -P "%F{33}Installing ZDHARMA-CONTINUUM Zinit...%f"
    command mkdir -p "$(dirname $ZINIT_HOME)"
    command git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" && \
        print -P "%F{34}Installation successful.%f" || \
        print -P "%F{160}Installation failed.%f"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Load annexes (without Turbo for stability)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# Essential plugins (load immediately)
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light olets/zsh-abbr  # Fish-like abbreviations (must load before abbr commands)

# Deferred plugins (load after 1-5 seconds)
zinit ice wait"1" lucid
zinit light hcgraf/zsh-sudo

zinit ice wait"5" lucid
zinit light thetic/extract

# ============================================
#  Shell Options & History
# ============================================

# Disable default zsh history (Atuin handles this)
HISTFILE=/dev/null
HISTSIZE=0
SAVEHIST=0
unsetopt APPEND_HISTORY
unsetopt INC_APPEND_HISTORY
unsetopt SHARE_HISTORY

# Keep useful shell options
setopt NO_CASE_GLOB
setopt AUTO_CD                  # Fish-like: type directory name to cd
setopt AUTO_PUSHD              # Fish-like: cd pushes to directory stack
setopt PUSHD_IGNORE_DUPS       # Don't push duplicates
setopt PUSHD_SILENT            # Don't print directory stack

# Fish-like corrections
setopt CORRECT                 # Command correction
# setopt CORRECT_ALL           # Argument correction (commented out - can be annoying)

# ============================================
#  Fish-like Autosuggestions Configuration
# ============================================

# Autosuggestion styling (more visible like fish)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'  # Bright gray
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1

# Fish-like accept autosuggestion
bindkey '^[[Z' autosuggest-accept  # Shift+Tab to accept
bindkey '^ ' autosuggest-accept    # Ctrl+Space to accept (fish-like)

# Vi mode only outside Neovim terminal
if [[ -z "$NVIM" ]]; then
    bindkey -v
else
    bindkey -e
fi

# ============================================
#  Fish-like Key Bindings
# ============================================

# Directory navigation (fish-like Alt+Left/Right)
bindkey '\e[1;3D' backward-word                 # Alt+Left
bindkey '\e[1;3C' forward-word                  # Alt+Right

# Delete key fixes
bindkey '^[[3~' delete-char
bindkey '^[3;5~' delete-char

# Home/End keys
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

# ============================================
#  Completions (Optimized with Cache)
# ============================================

autoload -Uz compinit

# Cache completions for 24 hours
setopt EXTENDEDGLOB
for dump in $HOME/.zcompdump(N.mh+24); do
    compinit
    if [[ -s "$dump" && (! -s "${dump}.zwc" || "$dump" -nt "${dump}.zwc") ]]; then
        zcompile "$dump"
    fi
done
compinit -C
unsetopt EXTENDEDGLOB

# Fish-like completion styling
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"  # Colorful completions
zstyle ':completion:*' group-name ''                      # Group results
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
zstyle ':completion:*:corrections' format '%F{green}-- %d (errors: %e) --%f'

# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

# Fuzzy matching
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Better process completion
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# Command completion: verbose with descriptions
zstyle ':completion:*' verbose yes
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

# ============================================
#  Core Tool Initializations
# ============================================

# Zoxide (essential, load immediately)
eval "$(zoxide init zsh)"

# Starship prompt (essential, load immediately)
eval "$(starship init zsh)"

# Atuin (history search - load immediately if you use it often)
# Comment out if you don't use it regularly
eval "$(atuin init zsh)"

# FZF integration
source <(fzf --zsh)

# ============================================
#  Lazy-Loaded Tools (Performance Optimization)
# ============================================

# Node Version Manager (FNM) - Load immediately
if command -v fnm &>/dev/null; then
    eval "$(fnm env --use-on-cd --shell zsh)"
fi

# JJ completion (lazy-load for performance)
if command -v jj &>/dev/null; then
    _jj_lazy_complete() {
        eval "$(command jj util completion zsh)"           # ← 加 command
        unset -f _jj_lazy_complete
        compinit
    }
    jj() {
        _jj_lazy_complete
        unfunction jj
        command jj "$@"
    }
fi
# GitHub CLI completions (lazy-load)
if (( $+commands[gh] )); then
    _gh_lazy_complete() {
        # Use 'command gh' to bypass the shell function and avoid recursion
        source <(command gh completion --shell zsh)
        unset -f _gh_lazy_complete
    }

    gh() {
        _gh_lazy_complete
        # Unfunction itself so this wrapper only runs once per session
        unfunction gh
        command gh "$@"
    }
fi
# SDKMAN (Java version manager - heavy, lazy-load)
if [[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]]; then
    _sdkman_lazy_init() {
        unset -f sdk java gradle maven _sdkman_lazy_init
        source "$SDKMAN_DIR/bin/sdkman-init.sh"
    }
    sdk()    { _sdkman_lazy_init; sdk "$@"; }
    java()   { _sdkman_lazy_init; command java "$@"; }
    gradle() { _sdkman_lazy_init; command gradle "$@"; }
    maven()  { _sdkman_lazy_init; command maven "$@"; }
fi
# Conda (lazy-load only when needed)
_conda_lazy_init() {
    local CONDA_BASE="/opt/homebrew/Caskroom/miniconda/base"
    
    if [[ -x "$CONDA_BASE/bin/conda" ]]; then
        __conda_setup="$("$CONDA_BASE/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
        if [ $? -eq 0 ]; then
            eval "$__conda_setup"
        else
            if [ -f "$CONDA_BASE/etc/profile.d/conda.sh" ]; then
                source "$CONDA_BASE/etc/profile.d/conda.sh"
            else
                export PATH="$CONDA_BASE/bin:$PATH"
            fi
        fi
        unset __conda_setup
    fi
    
    unset -f conda mamba _conda_lazy_init
}
conda() { _conda_lazy_init; conda "$@"; }
mamba() { _conda_lazy_init; mamba "$@"; }

# Bun completions
[[ -s "$HOME/.bun/_bun" ]] && source "$HOME/.bun/_bun"

# ============================================
#  SSH Agent (Single Instance)
# ============================================

_setup_ssh_agent() {
    local agent_sock="$HOME/.ssh/ssh-agent.sock"
    
    if [[ -z "$SSH_AUTH_SOCK" ]]; then
        # Try to reuse existing agent
        if [[ -S "$agent_sock" ]]; then
            export SSH_AUTH_SOCK="$agent_sock"
        else
            # Start new agent
            eval "$(ssh-agent -s)" > /dev/null
            ln -sf "$SSH_AUTH_SOCK" "$agent_sock"
        fi
        
        # Add key if not already loaded
        if ! ssh-add -l &>/dev/null; then
            ssh-add "$HOME/.ssh/id_ed25519" 2>/dev/null
        fi
    fi
}

_setup_ssh_agent

# ============================================
#  Custom Functions
# ============================================

# Smart Tmux launcher
smart_tmux() {
    [[ ! -o interactive ]] && return
    command -v tmux &>/dev/null || return
    
    if [[ -n "$TMUX" ]]; then
        local current_session=$(tmux display-message -p '#S') echo "📺 Already in tmux session: $current_session"
        return
    fi
    
    [[ "$TERM_PROGRAM" == "vscode" ]] && return
    
    local session_name="${1:-main}"
    echo "🚀 Starting tmux..."
    tmux new-session -A -s "$session_name"
}

# Cross-platform clipboard copy
copy() {
    if $IS_MAC; then
        pbcopy
    else
        wl-copy
    fi
}

# Yazi with directory change support
y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# Task wrapper with auto-sync
task() {
    command task "$@"
    [[ $# -gt 0 ]] && command task sync
}

# Fish-like 'take' command (mkdir + cd)
take() {
    mkdir -p "$1" && cd "$1"
}

# Fish-like 'mkcd' alternative
mkcd() {
    take "$@"
}

# Quick directory navigation
up() {
    local count="${1:-1}"
    local path=""
    for ((i=0; i<count; i++)); do
        path="../$path"
    done
    cd "$path"
}

# 用法: gwt-multi prefix name1 name2 name3 ...
# 例子: gwt-multi feature auth payment dashboard
gwt-multi() {
    # 如果没有参数，显示用法
    if [ $# -lt 2 ]; then
        echo "Usage: gwt-multi <prefix> <name1> <name2> ..."
        echo "Example: gwt-multi feat login ui api"
        return 1
    fi

    local prefix=$1
    shift # 弹出第一个参数作为前缀

    for name in "$@"; do # 统一格式：分支名用 /，文件夹名用 -
        local branch_name="${prefix}/${name}"
        local folder_name="${prefix}-${name}"
        
        # 检查目录是否已存在，避免报错
        if [ -d "../$folder_name" ]; then
            echo "⚠️  Directory ../$folder_name already exists, skipping..."
            continue
        fi

        echo "🚀 Creating worktree: $branch_name -> ../$folder_name"
        
        # 执行创建：基于当前分支创建新分支并挂载工作树
        git worktree add "../$folder_name" -b "$branch_name"
    done
}
# ============================================
#  Fish-like Abbreviations
# ============================================
# Only define if not already saved (checks if gst exists as representative)

if ! abbr list 2>/dev/null | grep -q 'gst'; then
    # Git abbreviations
    abbr gst='git status'
    abbr gco='git checkout'
    abbr gcm='git commit -m'
    abbr gp='git push'
    abbr gpl='git pull'
    abbr gd='git diff'
    abbr ga='git add'
    abbr gaa='git add --all'
    abbr gcb='git checkout -b'
    abbr gl='git log --oneline --graph --decorate'

    # Docker abbreviations
    abbr dk='docker'
    abbr dkc='docker compose'
    abbr dkps='docker ps'
    abbr dki='docker images'
    abbr dkrm='docker rm'
    abbr dkrmi='docker rmi'

    # System abbreviations  
    abbr pn='pnpm'
    abbr pni='pnpm install'
    abbr pnr='pnpm run'
    abbr pnd='pnpm run dev'

    # Navigation abbreviations
    abbr ..='cd ..'
    abbr ...='cd ../..'
    abbr ....='cd ../../..'
    abbr ~='cd ~'
    abbr -='cd -'
fi

# ============================================
#  Abbliases
# ============================================

# Core tool replacements
alias vi="nvim"
alias vim="nvim"
alias cat="bat"
alias ls="eza -la --icons"
alias ll="eza -l --icons"
alias x="ouch"
alias sudoedit="sudo -e"

# Quick access
alias yz="yazi"
alias za="zellij a"
alias tui="taskwarrior-tui"
alias ta='smart_tmux'
alias ocr="uv run ~/.local/bin/ocr.py"

# Git shortcuts
alias gl="git log --oneline"
alias gs="git status"
alias gd="git diff"

# custom 
alias n8n="fnm exec --using=20 npx n8n"
alias shizuku="adb shell sh /storage/emulated/0/Android/data/moe.shizuku.privileged.api/start.sh"
alias opc="opencode"

# macOS-specific
if $IS_MAC; then
    alias typora="/Applications/Typora.app/Contents/MacOS/Typora"
fi

# ============================================
#  External Configuration
# ============================================

# Load API keys if available
[[ -f "$HOME/.aikeys" ]] && source "$HOME/.aikeys"

# ============================================
#  Optional: ohcrab (verify this works)
# ============================================

if command -v ohcrab &>/dev/null; then
    crab() {
        export OHCRAB_SHELL="zsh"
        export OHCRAB_ALIAS="crab"
        export OHCRAB_COMMAND_HISTORY="$(fc -ln -1)"
        OC_CMD=$(ohcrab OHCRAB_ARGUMENT_PLACEHOLDER "$@") && eval "$OC_CMD"
        unset OHCRAB_COMMAND_HISTORY
    }
fi

# ============================================
#  Startup Message (Optional)
# ============================================

# Uncomment if you want a clean startup indicator
# echo "✨ Shell initialized in ${$(( $(date +%s%N) / 1000000 - $_zsh_start_time ))}ms"

# Added by Antigravity
export PATH="/Users/joexu/.antigravity/antigravity/bin:$PATH"

# bun completions
[ -s "/Users/joexu/.bun/_bun" ] && source "/Users/joexu/.bun/_bun"

# jj completion - moved to lazy-load section above (line ~225)
# Lazy loading improves startup time by ~35ms

export PATH="$HOME/.local/bin:$PATH"

# OpenClaw Completion (lazy-load for performance - saves ~2.6 seconds!)
if command -v openclaw &>/dev/null; then
    _openclaw_lazy_complete() {
        eval "$(command openclaw completion --shell zsh)"  # ← 加 command
        unset -f _openclaw_lazy_complete
        compinit
    }
    openclaw() {
        _openclaw_lazy_complete
        unfunction openclaw                                # ← 先删自己
        command openclaw "$@"                              # ← 再调真实命令
    }
fi
. "$HOME/.local/share/../bin/env"

# eval $(op signin)
