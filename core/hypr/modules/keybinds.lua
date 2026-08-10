-- =====================================================================
-- KEYBINDS
-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
-- =====================================================================

local mainMod = "SUPER"

-- ---------------------------------------------------------------------
-- Gestión de Ventanas (Foco, Estados y Cierre)
-- ---------------------------------------------------------------------
hl.bind(mainMod .. " + Return",    hl.dsp.exec_cmd(terminal))          -- Abrir terminal
local closeWindowBind = hl.bind(mainMod .. " + Backspace", hl.dsp.window.close())   -- Cerrar Ventana
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E",         hl.dsp.exec_cmd(fileManager))       -- Abrir FileManager
hl.bind(mainMod .. " + T",         hl.dsp.window.float({ action = "toggle" }))     -- Ventana Flotante
hl.bind(mainMod .. " + D",         hl.dsp.exec_cmd(menu))              -- Menu de Apps
-- hl.bind(mainMod .. " + w",         hl.dsp.exec_cmd(active_windows))                -- Ventanas activas
hl.bind(mainMod .. " + B",         hl.dsp.exec_cmd(browser))           -- Navegador
hl.bind(mainMod .. " + C",         hl.dsp.exec_cmd(ide))               -- IDE
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd(novelas))           -- Novelas Visuales

-- Gestor de las ventanas
hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen({ mode = 1 }))         -- Fullscreen Ventana
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen_state({ internal = 0, client = 2, action = "toggle" })) -- Fullscreen App
hl.bind(mainMod .. " + J",         hl.dsp.layout("togglesplit"))                   -- Togglesplit
-- hl.bind(mainMod .. " + L",         hl.dsp.exec_cmd("hyprlock"))                    -- Hyprlock
hl.bind(mainMod .. " + P",         hl.dsp.window.pin())     -- Pin a ventana | Tab para ciclar ventanas
hl.bind(mainMod .. " + Tab", function()
  local win = hl.get_active_window()
  local internalState = win ~= nil and win.fullscreen or 0
  local clientState = win ~= nil and win.fullscreenClient or 0
  hl.dispatch(hl.dsp.window.cycle_next({ next = true }))
  hl.dispatch(hl.dsp.window.fullscreen_state({
    internal = internalState,
    client = clientState,
    action = "set"
  }))
end)

-- ---------------------------------------------------------------------
-- Controles de Medios (Playerctl)
-- ---------------------------------------------------------------------
hl.bind(mainMod .. " + ALT + left",  hl.dsp.exec_cmd("playerctl previous"))
hl.bind(mainMod .. " + ALT + right", hl.dsp.exec_cmd("playerctl next"))
hl.bind(mainMod .. " + ALT + down",  hl.dsp.exec_cmd("playerctl play-pause"))

-- ---------------------------------------------------------------------
-- Capturas de pantalla (Grimblast)
-- ---------------------------------------------------------------------

-- ---------------------------------------------------------------------
-- Navegacion
-- ---------------------------------------------------------------------
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Teclas especiales (PageUp / PageDown) Navegar entre Workspaces 
hl.bind(mainMod .. " + code:112", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + code:117", hl.dsp.focus({ workspace = "e+1" }))

-- Scroll Raton (Navegar entre workspaces)
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Redimensionar ventanas (Mouse)
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Navegacion e intercambio de ventanas entre workspaces
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- ---------------------------------------------------------------------
-- Workspace Special + Hidden
-- ---------------------------------------------------------------------
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
hl.bind(mainMod .. " + H",         hl.dsp.workspace.toggle_special("hidden"))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ workspace = "special:hidden" }))

-- ---------------------------------------------------------------------
-- Control de Hardware y Multimedia (Teclas Especiales)
-- ---------------------------------------------------------------------
-- Audio y Brillo (Laptop)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Control de Reproducción (Teclas físicas dedicadas)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })