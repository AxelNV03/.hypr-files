// Importamos herramientas para leer archivos y rutas
use std::fs;                    // Para leer directorios
use std::path::PathBuf;         // Para construir rutas

// Estructura: una app con sus diseños disponibles
#[derive(Debug, Clone)]         // Permite imprimir y clonar
pub struct AppDesign {
    pub name: String,           // "waybar", "rofi"
    pub available: Vec<String>, // ["default", "design_1"]
}

// Función principal: escanea designs/ y devuelve lista de apps
pub fn scan_designs(base_dir: &str) -> Vec<AppDesign> {
    let mut apps = Vec::new();   // Vector vacío (como array dinámico)
    
    // Construye la ruta: base_dir/designs
    let designs_path = PathBuf::from(base_dir).join("designs");
    
    // Si no existe la carpeta, regresa vacío
    if !designs_path.exists() {
        eprintln!("No existe: {}", designs_path.display());
        return apps;
    }
    
    // Apps que vamos a ignorar
    let ignore = ["fastfetch", "gtk-3.0", "gtk-4.0"];
    
    // Leer el directorio designs/
    if let Ok(entries) = fs::read_dir(&designs_path) {
        for entry in entries.flatten() {
            let path = entry.path();
            let app_name = entry.file_name().to_string_lossy().to_string();
            
            // Si la app está en la lista de ignoradas, saltar
            if ignore.contains(&app_name.as_str()) {
                continue;
            }
            
            // Si no es directorio, saltar
            if !path.is_dir() {
                continue;
            }
            
            let mut designs = Vec::new();
            
            // Leer dentro de cada app (waybar/, rofi/...)
            if let Ok(design_entries) = fs::read_dir(&path) {
                for design in design_entries.flatten() {
                    let design_path = design.path();
                    let design_name = design.file_name().to_string_lossy().to_string();
                    
                    if design_path.is_dir() {
                        // Ej: waybar/default/ → "default"
                        designs.push(design_name);
                    } else if design_path.is_file() {
                        // Ej: hyprlock/default.conf → "default"
                        if let Some(stem) = design_path.file_stem() {
                            designs.push(stem.to_string_lossy().to_string());
                        }
                    }
                }
            }
            
            designs.sort();     // Ordenar alfabéticamente
            designs.dedup();    // Eliminar duplicados
            
            if !designs.is_empty() {
                apps.push(AppDesign {
                    name: app_name,
                    available: designs,
                });
            }
        }
    }
    
    apps.sort_by(|a, b| a.name.cmp(&b.name));
    apps
}