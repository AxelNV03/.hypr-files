-- para usar espacio como líder
-- vim.g.mapleader = " "

-- Abre NERDTree en la ubicación actual
vim.api.nvim_set_keymap("n", "<leader>a", ":NERDTreeFind<CR>", { noremap = true, silent = true })

-- Atajos de teclado adicionales
vim.api.nvim_set_keymap("n", "<leader>e", ":NERDTreeToggle<CR>", { noremap = true, silent = true }) -- Alternar NERDTree

-- Abre el terminal en la parte derecha de la pantalla con un tamaño de 37 columnas
vim.api.nvim_set_keymap('n', '<leader>t', '<cmd>lcd %:p:h<CR><cmd>botright 40vsplit term://bash<CR><cmd>startinsert<CR>', { noremap = true, silent = true })

-- Mapear Esc para salir del modo terminal
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

-- Cerrar la ventana o el buffer
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })

-- Guardar el archivo
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })

-- Guardar y cerrar el archivo
vim.api.nvim_set_keymap('n', '<leader><BS>', ':wq<CR>', { noremap = true, silent = true })

-- Abrir un split debajo de la ventana actual
vim.api.nvim_set_keymap('n', '<leader>l', ':split<CR>', { noremap = true, silent = true })

-- Abrir un vsplit a la derecha de la ventana actual
vim.api.nvim_set_keymap('n', '<leader>p', ':vsplit<CR>', { noremap = true, silent = true })











-- Mapeos para moverse entre ventanas usando la tecla líder + flechas
vim.api.nvim_set_keymap('n', '<leader><Left>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><Right>', '<C-w>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><Up>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><Down>', '<C-w>j', { noremap = true, silent = true })

-- Redimensionar entre ventanas usando la tecla líder + n + flechas
vim.api.nvim_set_keymap('n', '<leader>n<Down>', ':resize +5<CR>', { noremap = true, silent = true })

-- Redimensionar hacia abajo (con <leader>n + flecha hacia abajo)
vim.api.nvim_set_keymap('n', '<leader>n<Up>', ':resize -5<CR>', { noremap = true, silent = true })

-- Redimensionar hacia la derecha (con <leader>n + flecha derecha)
vim.api.nvim_set_keymap('n', '<leader>n<Left>', ':vertical resize +5<CR>', { noremap = true, silent = true })

-- Redimensionar hacia la izquierda (con <leader>n + flecha izquierda)
vim.api.nvim_set_keymap('n', '<leader>n<Right>', ':vertical resize -5<CR>', { noremap = true, silent = true })

