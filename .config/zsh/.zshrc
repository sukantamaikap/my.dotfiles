# Show system info on startup
/opt/homebrew/bin/neofetch

# Early environment setup
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"  # for M1/M2 Macs

# Bootstrap dependencies that may produce console output before instant prompt.
mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}/zinit/completions"
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname "$ZINIT_HOME")"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Ensure Neovim environment
export NVIM_LOG_FILE="$XDG_DATA_HOME/nvim/log/nvim.log"

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
# zinit snippet OMZP::macos
zinit snippet OMZP::ssh
zinit snippet OMZP::python
zinit snippet OMZP::pip
zinit snippet OMZP::npm
zinit snippet OMZP::ansible
zinit snippet OMZP::battery
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::docker
zinit snippet OMZP::docker-compose
zinit snippet OMZP::eza
# zinit snippet OMZP::archlinux
# zinit snippet OMZP::aws
# zinit snippet OMZP::kubectl
# zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Docker Desktop completions must be added before compinit.
fpath=(/Users/sukantamaikap/.docker/completions $fpath)

# Load completions once.
autoload -Uz compinit && compinit

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias c='clear'
alias n='nvim'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Source your dev environment early
source "$HOME/.devenv"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# excalidraw
alias excalidraw="docker run --rm -dit --name excalidraw -p 5050:80 excalidraw/excalidraw:latest && sleep 2 && open http://localhost:5050"
alias excalidraw-stop="docker stop excalidraw"

# 🕵️ SearXNG Management (Mac & Linux Compatible)
searx-start() {
    local PORT=8080
    local NAME="searxng"
    local URL="http://localhost:$PORT"
    local CONFIG_DIR="$HOME/.config/searxng"

    echo "🔍 Checking environment..."

    # 1. Check if Docker daemon is running
    if ! docker info >/dev/null 2>&1; then
        echo "🐳 ❌ Error: Docker isn't running!"
        return 1
    fi

    # 2. Check for existing containers
    local EXISTING_ID=$(docker ps -aq -f name=^/${NAME}$)
    if [ -n "$EXISTING_ID" ]; then
        if [ "$(docker ps -q -f id=$EXISTING_ID)" ]; then
            echo "✅ $NAME is already cruising!"
            # Detect OS for opening the browser
            [[ "$OSTYPE" == "darwin"* ]] && open "$URL" || xdg-open "$URL" 2>/dev/null
            return 0
        else
            echo "🧟 Cleaning up stopped container..."
            docker rm "$EXISTING_ID" >/dev/null
        fi
    fi

    # 3. Port Conflict Check (Works on both)
    local PORT_INFO=$(lsof -i :$PORT -sTCP:LISTEN -n -P | awk 'NR==2 {print $1, $2}')
    if [ -n "$PORT_INFO" ]; then
        local PROC_NAME=$(echo $PORT_INFO | awk '{print $1}')
        local PROC_PID=$(echo $PORT_INFO | awk '{print $2}')
        echo "🚫 🚧 Conflict: Port $PORT is busy!"
        echo "   └─ Process: $PROC_NAME (PID: $PROC_PID)"
        return 1
    fi

    echo "🚀 Launching SearXNG..."
    docker run --rm  \
      -d \
      --name "$NAME" \
      -p "$PORT":8080 \
      -v "$CONFIG_DIR/settings.yml:/etc/searxng/settings.yml:ro" \
      -v "$CONFIG_DIR/limiter.toml:/etc/searxng/limiter.toml:ro" \
      -e "SEARXNG_SETTINGS_PATH=/etc/searxng/settings.yml" \
      searxng/searxng:latest

    echo "📜 Tailing logs for 4s..."
    (docker logs -f "$NAME" & sleep 4; kill $! 2>/dev/null) 

    echo "🧪 Polling health status..."
    local count=0
    while ! curl -s -o /dev/null -w "%{http_code}" "$URL" | grep -q "200"; do
        if [ $count -gt 15 ]; then
            echo "⚠️  Timeout: SearXNG is taking too long."
            return 1
        fi
        echo "⏳ Still warming up..."
        sleep 1
        ((count++))
    done

    echo "✨ Engine is healthy!"
    # Handle Mac vs Linux browser opening
    if [[ "$OSTYPE" == "darwin"* ]]; then
        open "$URL"
    elif command -v xdg-open > /dev/null; then
        xdg-open "$URL" 2>/dev/null
    else
        echo "🌍 SearXNG is ready at $URL"
    fi
}

export SEARXNG_URL="http://localhost:8080"
alias ollama-restart='brew services restart ollama'
