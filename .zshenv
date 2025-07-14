# Load local/private environment variables if the file exists
if [ -f "${ZDOTDIR:-$HOME}/.zshenv.local" ]; then
  . "${ZDOTDIR:-$HOME}/.zshenv.local"
fi
