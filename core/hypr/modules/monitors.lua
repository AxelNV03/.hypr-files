-- =====================================================================
-- MONITORES
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- =====================================================================

-- Regla específica para laptop
hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "0x0",
    scale    = 1,
})

-- Regla específica para un externo conocido (ajustar al nombre real)
hl.monitor({
    output   = "DP-1",
    mode     = "preferred",
    position = "auto-right",   -- se coloca a la derecha del laptop automáticamente
    scale    = 1,
})

-- Cualquier OTRO monitor que se conecte sin regla propia
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

