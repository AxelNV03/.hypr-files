# Hyprland Dotfiles

Configuración modular de Hyprland (Lua, 0.55+) para CachyOS, con arquitectura de composición: cada pieza estética o funcional es independiente y combinable, sin monolitos por perfil.

## Filosofía

> El profile es la receta. `core` / `designs` / `colors` son la alacena.

La receta no contiene los ingredientes — solo dice qué usar de dónde. Podés cambiar un ingrediente puntual sin reescribir el plato completo, y un ingrediente que sobra de una receta queda disponible para la próxima sin duplicar nada.

## Arquitectura

| Capa | Responde a | Contenido | Se repite entre perfiles |
|---|---|---|---|
| **`core/`** | ¿Cómo funciona? | Lógica y comportamiento puro, sin opinión visual (módulos, funciones, curvas bezier) | Siempre se carga, no varía |
| **`designs/`** | ¿Cómo se organiza y se ve? | Layout + estilo (forma, tamaños, transparencia) — fusionados porque están acoplados entre sí | Sí, por app |
| **`colors/`** | ¿Con qué paleta se pinta? | Solo variables de color, aplicadas sobre un design | Sí, independiente de todo lo demás |
| **`profiles/`** | ¿Qué combinación uso ahora? | Manifiestos `.toml` — solo referencias por nombre, nunca contenido real | Uno por combinación deseada |

### Reglas de clasificación para cualquier archivo nuevo

1. ¿Es lógica/comportamiento reusable, sin opinión visual? → `core/`
2. ¿Es forma/acomodo, y layout+estilo dependen entre sí? → `designs/` (van juntos, no se separan)
3. ¿Es solo color, consumible por cualquier design sin saber su origen? → `colors/`

**No atomizar por atomizar.** Layout y estilo parecían candidatos a separarse (como color), pero un módulo en el layout sin su estilo correspondiente rompe visualmente — por eso van fusionados en `designs/`. Color sí es genuinamente independiente de todo lo demás.

## Estructura de carpetas

```
.hyprland-dotfiles/
├── core/
│   ├── hypr/
│   │   ├── conf/           -- estructural: binds, rules, monitors, autostart, etc.
│   │   ├── curves.lua      -- primitivas bezier/spring, compartidas por todos los designs
│   │   └── hyprland.lua    -- entry point
│   └── zsh/                -- funciones y alias reusables, sin estética
├── designs/
│   ├── hypr/
│   │   └── <nombre>/
│   │       ├── appearance.lua   -- gaps, border, blur, sombras
│   │       └── animations.lua   -- qué curva usa cada leaf, a qué velocidad
│   ├── waybar/
│   │   └── <nombre>/
│   │       ├── layout.json      -- qué módulos, orden, posición
│   │       └── style.css        -- tamaños, paddings, radios (sin colores)
│   ├── rofi/
│   └── kitty/
├── colors/
│   └── <app>/
│       └── default.css     -- seed inmutable, nunca lo pisa matugen
├── generated/               -- resultado real de matugen, mutable, gitignored
├── profiles/
│   └── <nombre>.toml        -- manifiesto: qué design + qué colors usa cada app
├── machine/
│   └── <hostname>/          -- dotfiles específicos de una sola máquina, no se instalan por defecto
├── installation/
│   ├── install.sh
│   └── packages.txt
├── scripts/
│   └── switch-profile.sh
└── wallpapers/
```

## Cómo funciona un perfil

```toml
# profiles/default.toml
hypr_design    = "default"
waybar_design  = "green-sky"
waybar_colors  = "matugen"
rofi_design    = "green-sky"
kitty_design   = "green-sky"
wallpaper      = "green-sky"
```

`scripts/switch-profile.sh <nombre>` lee el `.toml` y crea los symlinks correspondientes desde `designs/` y `colors/` hacia la config real que cada app lee (`~/.config/waybar/`, `~/.config/hypr/`, etc.), guarda el perfil activo en `.active_profile`, y recarga Hyprland.

## Matugen (colores dinámicos)

- `core/matugen/templates/` → moldes con sintaxis de cada app, con huecos para los valores de color
- `generated/<app>-colors.*` → resultado real, lo que la app consume día a día
- `colors/<app>/default.css` → se **copia** (no se referencia) a `generated/` en la instalación, así siempre hay colores presentes aunque matugen nunca haya corrido
- `scripts/reset-colors.sh` → vuelve a copiar el default sobre `generated/`

## Convenciones

- `require()` de Hyprland-Lua resuelve rutas relativas a `~/.config/hypr/` — todo lo que necesite `require()` normal debe vivir dentro de ese árbol o llegar por symlink.
- Nombres de archivo/require siempre coincidentes en singular o plural (evitar `window-rule.lua` vs `require("window-rules")`).
- `machine/<hostname>/` nunca se instala por defecto; el instalador lo detecta automáticamente por `hostname` y lo aplica solo si existe.

## Pendiente

- [ ] `installation/` — stack base (IDE, browser, bluetooth, wifi), orden: mirrors → pacman → paru → services → symlinks → tlp
- [ ] `scripts/switch-profile.sh` real
- [ ] Migrar Waybar/Rofi/Kitty al patrón core/designs/colors
- [ ] Combinador de piezas (Rofi dmenu encadenado → futuro panel AGS/Astal con preview)
