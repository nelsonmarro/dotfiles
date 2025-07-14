if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(zsh-autosuggestions zsh-syntax-highlighting fzf-tab git archlinux)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
autoload -U compinit && compinit
source "$ZSH/oh-my-zsh.sh"

# Environment Variables
export BROWSER=firefox
export EDITOR="nvim"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
source "$HOME/.cargo/env" 

export ANDROID_NDK_HOME=$HOME/Android/Sdk/ndk/28.0.12674087
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools/
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin/
export PATH=$PATH:$ANDROID_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/tools/
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk/

export CAPACITOR_ANDROID_STUDIO_PATH=/home/nelson/.local/share/JetBrains/Toolbox/apps/android-studio/bin/studio.sh 

AVALONIA_GLOBAL_SCALE_FACTOR=2
export AVALONIA_GLOBAL_SCALE_FACTOR

export GOBIN=$HOME/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH
export PATH=$PATH:$GOBIN

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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

# Shell functions
# Function to run Go test coverage for a specified package and open the HTML report
go_coverage() {
  local package_path=""
  local tags_flag=""
  local cover_profile="coverage.out" # Output file for coverage data

  # Parse arguments
  while (( "$#" )); do
    case "$1" in
      -tags | --tags)
        if [ -n "$2" ]; then
          tags_flag="-tags=$2"
          shift 2 # Consume flag and its value
        else
          echo "Error: -tags requires an argument (e.g., -tags=integration)"
          return 1
        fi
        ;;
      -h | --help)
        echo "Usage: go_coverage [OPTIONS] <./your/package/path>"
        echo "  -tags <tag_name> or --tags=<tag_name> : Specify build tags for tests (e.g., integration)"
        echo "Example: go_coverage -tags integration ./service"
        echo "Example: go_coverage ./... -tags=integration"
        echo "Example: go_coverage ./admin"
        return 0
        ;;
      -*) # Unknown flag
        echo "Error: Unknown option '$1'"
        echo "Use 'go_coverage --help' for usage."
        return 1
        ;;
      *) # Package path (must be the last non-flag argument)
        if [ -z "$package_path" ]; then
          package_path="$1"
        else
          echo "Error: Multiple package paths specified or invalid argument order."
          echo "Usage: go_coverage [OPTIONS] <./your/package/path>"
          echo "Use 'go_coverage --help' for usage."
          return 1
        fi
        shift # Consume package path
        ;;
    esac
  done

  # Check if package_path was provided
  if [ -z "$package_path" ]; then
    echo "Error: No package path provided."
    echo "Usage: go_coverage [OPTIONS] <./your/package/path>"
    echo "Use 'go_coverage --help' for usage."
    return 1
  fi

  echo "Running tests for '$package_path' with tags '$tags_flag' and generating coverage report..."

  # Construct the go test command
  local go_test_cmd="go test -v"
  if [ -n "$tags_flag" ]; then
    go_test_cmd+=" ${tags_flag}"
  fi
  go_test_cmd+=" -coverprofile=${cover_profile} ${package_path}"

  # Execute the command
  eval "$go_test_cmd" && go tool cover -html="${cover_profile}"

  if [ $? -eq 0 ]; then
    echo "Coverage report generated and opened successfully."
  else
    echo "Failed to generate or open coverage report. Check the output above for errors."
  fi
}
# Aliases
alias ls='ls --color'
alias c='clear'
alias e='exit'
alias vim="nvim"
alias vi="nvim"
alias ls="ls --color"
alias gocov="go_coverage"
# alias air='~/.air'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
source /usr/share/nvm/init-nvm.sh

export QT_SELECT=6

# Load Angular CLI autocompletion.
source <(ng completion script)

# bun completions
[ -s "/home/nelson/.bun/_bun" ] && source "/home/nelson/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export GEMINI_API_KEY="AIzaSyAwoLBBdr1YPYthwktYOG7jfZ54irPIn4g"
# For .bashrc or .zshrc
export GPG_TTY=$(tty)
# zsh parameter completion for the dotnet CLI

_dotnet_zsh_complete()
{
  local completions=("$(dotnet complete "$words")")

  # If the completion list is empty, just continue with filename selection
  if [ -z "$completions" ]
  then
    _arguments '*::arguments: _normal'
    return
  fi

  # This is not a variable assignment, don't remove spaces!
  _values = "${(ps:\n:)completions}"
}
compdef _dotnet_zsh_complete dotnet

export SSL_CERT_DIR=$HOME/.aspnet/dev-certs/trust:/usr/lib/ssl/certs

export JIRA_API_TOKEN=ATATT3xFfGF0QcYmBOVraWyQ4jgClt4_aOX1W-FlgyUyHVoDfC93reHhHUjXNCR0o83tiAKQwBqkC6d2AL0nnMGtSxXEkl6YmYtx55OjDNt3mxqRQQyf8YiePGmLlIxb6efYUBwVg-4--CZuxL_BsGrTUdmb8_5AZjohffn4sWZXCusr-dv415I=F90C5878
