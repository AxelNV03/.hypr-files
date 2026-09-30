-- =====================================================================
-- WINDOW RULES
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- =====================================================================
local color = require("modules/colors")
local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)
hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    match = { fullscreen = true },
    border_size = 0,
    fullscreen_state = "3 3"
})

-- Regla de ventana para el monitor de procesos flotante lanzado desde Waybar
hl.window_rule({
  match = { 
    class = "waybar-monitor" 
  },
  float = true,
  size  = { "850", "550" }, -- La API pide strings para expresiones o medidas fijas
  center = true
})

-- Regla de ventana para Thunar (Explorador de Archivos GTK3)
hl.window_rule({
    match = { 
        class = "thunar" 
    },
    -- Aplicamos la opacidad activa, inactiva y enfocada (equivalente a tu rule de Hyprland)
    opacity = "0.85 override 0.85 override 0.85",
    -- Adicionalmente, forzamos que el borde inactivo haga juego con tu paleta de fondo
})

hl.window_rule({
    match = { 
        class = "kitty" 
    },
    -- Aplicamos la opacidad activa, inactiva y enfocada (equivalente a tu rule de Hyprland)
    opacity = "0.90 override 0.70 override 0.90",
    -- windowrule = opacity 0.97 override 0.97 override 0.97, match:class code
    -- Adicionalmente, forzamos que el borde inactivo haga juego con tu paleta de fondo
})

hl.window_rule({
    match = { 
        class = "code"
    },
    -- Aplicamos la opacidad activa, inactiva y enfocada (equivalente a tu rule de Hyprland)
    opacity = "0.95 override 0.95 override 0.95",
    -- Adicionalmente, forzamos que el borde inactivo haga juego con tu paleta de fondo
})

hl.window_rule({
    match = { 
        class = "firefox"
    },
    -- Aplicamos la opacidad activa, inactiva y enfocada (equivalente a tu rule de Hyprland)
    opacity = "0.95 override 0.90 override 0.90",
    -- Adicionalmente, forzamos que el borde inactivo haga juego con tu paleta de fondo
})

-- windowrule = opacity 0.95 override 0.95 override 0.95 , match:class firefox # Disable blur for firefox
hl.window_rule({
  name   = "scrcpy-floating",
  match  = { class = "scrcpy" },
  float  = true,
  size   = { 430, 910 },
  move = { "monitor_w - window_w - 20", 90 },
  pin    = true,
})