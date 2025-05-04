-- init.lua

-- 1. Cargar gestión de plugins
require("plugins")

-- 2. Cargar configuraciones generales
require("settings")

-- 3. Cargar atajos de teclado
require("keymaps")

-- 4. Cargar automáticamente todas las configuraciones de plugins
local plugin_configs = vim.fn.glob("~/.config/nvim/lua/plugin-configs/*.lua")
for _, file in ipairs(vim.split(plugin_configs, "\n")) do
  if file ~= "" then
    local config_name = file:match("([^/]+)%.lua$")
    if config_name then
      require("plugin-configs." .. config_name)
    end
  end
end

-- 5. Cargar automáticamente módulos personalizados
local custom_configs = vim.fn.glob("~/.config/nvim/lua/custom/*.lua")
for _, file in ipairs(vim.split(custom_configs, "\n")) do
  if file ~= "" then
    local config_name = file:match("([^/]+)%.lua$")
    if config_name then
      require("custom." .. config_name)
    end
  end
end
