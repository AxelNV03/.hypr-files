# Arranque rapido
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Carga los archivos de configuracion
source "$HOME/.config/zsh/config.zsh"
source "$HOME/.config/zsh/alias.zsh"
source "$HOME/.config/zsh/functions.zsh"

# di=01;38;5;226 (Carpetas Amarillo Fuerte)
# ex=01;38;5;46 (Ejecutables Verde Chillón 46)
export LS_COLORS=$LS_COLORS:'di=01;38;5;226:'
export LS_COLORS=$LS_COLORS:'di=01;38;5;226:ex=01;38;5;214:'
# Declarar el array para evitar el error de Zsh
typeset -gA ZSH_HIGHLIGHT_STYLES

# Verde Chillon (46) para comandos válidos
ZSH_HIGHLIGHT_STYLES[command]='fg=46,bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=46,bold'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=46,bold'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=46,bold'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=46,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=46,bold'


ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=160,bold'
