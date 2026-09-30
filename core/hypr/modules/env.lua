-- =====================================================================
-- ENVIRONMENT
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
-- =====================================================================
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
-- hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")   -- Colocar aqui el tema de cursor actual 

hl.env("GDK_BACKEND", "wayland,x11,*")         -- GTK: prioriza Wayland, cae a X11 si falla
hl.env("QT_QPA_PLATFORM", "wayland;xcb")       -- Qt: mismo comportamiento
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("MOZ_ENABLE_WAYLAND", "1")

-- Detectar wallpaper con cualquier extensión
local wallpaper = os.getenv("HOME") .. "/.config/wallpaper"
local ext = ""
for _, e in ipairs({".jpg", ".png", ".webp", ".gif"}) do
    local f = io.open(wallpaper .. e, "r")
    if f then
        f:close()
        ext = e
        break
    end
end
hl.env("WALLPAPER_PATH", wallpaper .. ext)
