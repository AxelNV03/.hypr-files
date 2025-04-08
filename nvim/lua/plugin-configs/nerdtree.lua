-- Configuración de NERDTree
vim.g.NERDTreeShowHidden = 1           -- Muestra archivos ocultos
vim.g.NERDTreeQuitOnOpen = 1           -- Cierra NERDTree al abrir un archivo
vim.g.NERDTreeAutoDeleteBuffer = 1     -- Elimina automáticamente los buffers no usados
vim.g.NERDTreeMinimalUI = 1            -- Interfaz minimalista
vim.g.NERDTreeDirArrows = 1            -- Usa flechas para directorios
vim.g.NERDTreeShowLineNumbers = 1      -- Muestra números de línea en NERDTree

-- Asigna la tecla '\t' para abrir archivos en una nueva pestaña
vim.api.nvim_set_keymap("n", "<leader>t", ":NERDTreeMapOpenInTab<CR>", { noremap = true, silent = true })

-- Atajos de teclado adicionales
vim.api.nvim_set_keymap("n", "<leader>e", ":NERDTreeToggle<CR>", { noremap = true, silent = true }) -- Alternar NERDTree
vim.api.nvim_set_keymap("n", "<leader>f", ":NERDTreeFind<CR>", { noremap = true, silent = true })   -- Encontrar archivo actual en NERDTree