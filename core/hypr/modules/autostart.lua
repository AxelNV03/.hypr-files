-- =====================================================================
-- PROGRAMAS
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
-- =====================================================================
hl.on("hyprland.start", function () 
  hl.exec_cmd("waybar") -- Execute waybar
  hl.exec_cmd("hyprpaper") -- Execute hyprpaper
  hl.exec_cmd("hyprsunset") -- Luz nocturna
  hl.exec_cmd("systemctl --user start hyprpolkitagent") -- Agente de polkit
  hl.exec_cmd("xsettingsd")
  --   hl.exec_cmd("hypridle") -- Agente de polkit
end)