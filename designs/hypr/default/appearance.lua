-- =====================================================================
-- THEME: default
-- =====================================================================
-- COLORES (Inyectados directamente al core de Hyprland desde Lua)
local color = require("modules/colors")
hl.config({
    general = {
        gaps_in  = 1,
        gaps_out = 4,0,0,0,
        border_size = 2,
        col = {
            active_border = {
                colors = { color.primary, color.secondary },
                angle = 45,
            },
            inactive_border = color.on_primary,
        },
    },
    decoration = {
        rounding       = 5,
        rounding_power = 5,
        active_opacity   = 1.0,
        inactive_opacity = 0.9,
        shadow = { enabled = false, range = 4, render_power = 3, color = color.background },
        blur = {
            enabled         = true,
            size            = 5,
            passes          = 3,
            ignore_opacity  = true,
            new_optimizations = true,
            special         = false,
            popups          = true,
            xray            = true,
            vibrancy        = 0.1696,
        },
    },
    animations = { enabled = true },
})

