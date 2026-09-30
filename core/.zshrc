# =====================================================================
#     ZSH CORE — Configuración funcional
# =====================================================================

# Cargar configuraciones
source ~/.config/zsh/config.zsh
source ~/.config/zsh/alias.zsh
source ~/.config/zsh/functions.zsh

# Iniciar starship
fastfetch
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
export PATH="$HOME/.local/bin:$PATH"

