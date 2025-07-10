vim.opt.number = true               -- Muestra números de línea
vim.opt.mouse = "a"                 -- Habilita el uso del ratón en todas los modos
vim.opt.numberwidth = 1             -- Establece el ancho mínimo de la columna de números de línea
vim.opt.clipboard = "unnamedplus"   -- Usa el portapapeles del sistema para copiar/pegar
vim.cmd([[syntax on]])              -- Habilita el resaltado de sintaxis
vim.opt.showcmd = true              -- Muestra comandos parciales en la barra de estado
vim.opt.ruler = true                -- Muestra la posición del cursor (línea/columna) en la barra de estado
vim.opt.cursorline = true           -- Resalta la línea actual donde está el cursor
vim.opt.encoding = "utf-8"          -- Establece la codificación del archivo a UTF-8
vim.opt.showmatch = true            -- Resalta automáticamente los paréntesis, corchetes o llaves coincidentes
vim.opt.termguicolors = true        -- Habilita colores RGB (necesario para temas modernos)
vim.opt.shiftwidth = 2              -- Establece el ancho de indentación para `shiftwidth`
vim.opt.relativenumber = true       -- Muestra números de línea relativos al cursor
vim.opt.laststatus = 2              -- Siempre muestra la barra de estado
-- vim.opt.showtabline = 2             -- Siempre muestra la línea de pestañas
vim.opt.tabstop = 4                 -- Establece el número de espacios que un tabulador representa




-- Tema Gruvbox
vim.cmd([[colorscheme gruvbox]])            -- Aplica el tema Gruvbox
vim.g.gruvbox_contrast_dark = "hard"        -- Ajusta el contraste en modo oscuro
vim.cmd([[highlight Normal ctermbg=NONE]])  -- Elimina el fondo de la ventana principal



-- Configuraciones de búsqueda
vim.opt.hlsearch = true     -- Resalta las coincidencias encontradas durante la búsqueda
vim.opt.incsearch = true    -- Habilita la búsqueda incremental (muestra coincidencias mientras escribes)
vim.opt.ignorecase = true   -- Hace que las búsquedas no distingan entre mayúsculas y minúsculas...
vim.opt.smartcase = true    -- ... excepto si la búsqueda contiene al menos una letra mayúscula


