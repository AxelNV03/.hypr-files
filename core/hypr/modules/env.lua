-- =====================================================================
--     ENVIRONMENT — Variables de entorno para Hyprland
-- =====================================================================

-- Cursor
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")

-- Backends Wayland
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- Sesión
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- Wallpaper (para hyprlock y otros)
local wallpaper = os.getenv("HOME") .. "/.config/wallpaper"
local ext = ".jpg"  -- fallback si no encuentra ninguno
for _, e in ipairs({".jpg", ".png", ".webp", ".gif"}) do
    local f = io.open(wallpaper .. e, "r")
    if f then
        f:close()
        ext = e
        break
    end
end
hl.env("WALLPAPER_PATH", wallpaper .. ext)