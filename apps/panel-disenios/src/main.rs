mod window;        // ← Declara que existe window.rs
mod tabs;          // ← Declara tabs/ (carpeta)
mod components;    // ← Declara components/ (carpeta)
mod utils;         // ← Declara utils/ (carpeta)

use gtk4::prelude::*;    // Traits de GTK (necesarios)
use gtk4::Application;   // La app GTK

fn main() {
    // Esto es SOLO PRUEBA del scanner
    let designs = utils::scanner::scan_designs("/home/nv/.hypr-files");
    for d in &designs {
        println!("{} → {:?}", d.name, d.available);
    }

    // App GTK
    let app = Application::builder()
        .application_id("com.hyprfiles.panel-disenios")
        .build();

    // Cuando la app arranca → construye la ventana
    app.connect_activate(|app| {
        window::build(app);
    });

    // Loop de eventos
    app.run();
}