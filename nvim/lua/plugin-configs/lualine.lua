-- Configuración de lualine
require("lualine").setup({
    options = {
      theme = "gruvbox", -- Usa el tema Gruvbox
      section_separators = { left = "", right = "" }, -- Separadores principales
      component_separators = { left = "", right = "" }, -- Separadores secundarios
      globalstatus = true, -- Barra de estado global (opcional)
    },
    sections = {
      -- Parte izquierda de la barra
      lualine_a = { "mode" }, -- Modo actual (Normal, Insertar, etc.)
      lualine_b = {}, -- Espacio vacío (equivalente a [] en lightline)
      lualine_c = { "filename" }, -- Nombre del archivo relativo con indicador de modificación
  
      -- Parte derecha de la barra
      lualine_x = { function() return vim.fn["kite#statusline"]() end }, -- Estado de Kite
      lualine_y = { "filetype", "progress", "location" }, -- Tipo de archivo, progreso y posición del cursor
      lualine_z = { "branch" }, -- Rama de Git
    },
    inactive_sections = {
      -- Parte izquierda para ventanas inactivas
      lualine_a = { "inactive" }, -- Estado inactivo
      lualine_b = { "filename" }, -- Nombre del archivo relativo
      lualine_c = {},
  
      -- Parte derecha para ventanas inactivas
      lualine_x = {},
      lualine_y = {},
      lualine_z = { "bufnum" }, -- Número de buffer
    },
  })