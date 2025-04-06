-- Líneas de configuración
vim.opt.number = true               -- Muestra los números de línea
vim.opt.mouse = 'a'                 -- Habilita el uso del ratón
vim.opt.numberwidth = 1             -- Ancho de la columna de números de línea
vim.opt.clipboard = 'unnamed'      -- Habilita el portapapeles compartido con el sistema
vim.opt.syntax = 'on'              -- Habilita la sintaxis
vim.opt.showcmd = true             -- Muestra los comandos parcialmente en la línea de estado
vim.opt.ruler = true               -- Muestra la posición del cursor
vim.opt.cursorline = true          -- Resalta la línea actual del cursor
vim.opt.encoding = 'utf-8'         -- Establece la codificación
vim.opt.showmatch = true           -- Resalta paréntesis coincidentes
vim.opt.termguicolors = true       -- Habilita colores de 24 bits
vim.opt.sw = 2                     -- Establece el tamaño de la indentación en 2 espacios
vim.opt.relativenumber = true      -- Muestra números de línea relativos

-- Colores y tema
vim.cmd('colorscheme gruvbox')     -- Aplica el esquema de colores gruvbox
vim.g.gruvbox_contrast_dark = 'hard' -- Establece el contraste en el tema gruvbox
vim.cmd('highlight Normal ctermbg=NONE') -- Elimina el fondo del Normal en el tema
vim.opt.laststatus = 2             -- Establece la barra de estado siempre visible
vim.opt.showmode = false           -- Desactiva la visualización del modo

-- Auto comandos
vim.cmd([[
  au BufNewFile,BufRead *.html set filetype=htmldjango
]])

-- Plugins
require'colorizer'.setup()

-- Configuración de búsqueda
vim.opt.hlsearch = true            -- Resalta las coincidencias
vim.opt.incsearch = true           -- Búsqueda incremental
vim.opt.ignorecase = true          -- Ignora mayúsculas/minúsculas en la búsqueda
vim.opt.smartcase = true           -- Hace la búsqueda sensible a mayúsculas si tiene al menos una letra mayúscula

-- Archivos de configuración externos
vim.cmd('source ~/.config/nvim/lua/plugins.vim')
vim.cmd('source ~/.config/nvim/lua/plugin-config.vim')
vim.cmd('source ~/.config/nvim/lua/maps.vim')
