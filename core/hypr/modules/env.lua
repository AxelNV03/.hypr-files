-- =====================================================================
-- ENVIRONMENT
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
-- =====================================================================
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
-- hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")   -- Colocar aqui el tema de cursor actual 

hl.env("GDK_BACKEND", "wayland,x11,*")         -- GTK: prioriza Wayland, cae a X11 si falla
hl.env("QT_QPA_PLATFORM", "wayland;xcb")       -- Qt: mismo comportamiento

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("MOZ_ENABLE_WAYLAND", "1")