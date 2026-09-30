use gtk4::gdk::Display;
use gtk4::prelude::*;
use gtk4::{Application, ApplicationWindow, CssProvider, Notebook};
use crate::tabs;

pub fn build(app: &Application) {
    let window = ApplicationWindow::builder()
        .application(app)
        .title("Panel de Diseños")
        .default_width(600)
        .default_height(500)
        .build();

    // Cargar CSS
    let provider = CssProvider::new();
    provider.load_from_path("styles/style.css");

    gtk4::style_context_add_provider_for_display(
        &Display::default().unwrap(),
        &provider,
        gtk4::STYLE_PROVIDER_PRIORITY_APPLICATION,
    );

    let notebook = Notebook::new();

    // Pestañas vacías por ahora
    // let designs = gtk4::Box::new(gtk4::Orientation::Vertical, 10);
    // designs.append(&gtk4::Label::new(Some("Diseños")));
    let designs = tabs::designs::build();

    let profiles = gtk4::Box::new(gtk4::Orientation::Vertical, 10);
    profiles.append(&gtk4::Label::new(Some("Perfiles")));

    let fastfetch = gtk4::Box::new(gtk4::Orientation::Vertical, 10);
    fastfetch.append(&gtk4::Label::new(Some("Fastfetch")));
    
    let wallpapers = gtk4::Box::new(gtk4::Orientation::Vertical, 10);
    wallpapers.append(&gtk4::Label::new(Some("Wallpapers")));


    notebook.append_page(&designs, Some(&gtk4::Label::new(Some("Diseños"))));
    notebook.append_page(&profiles, Some(&gtk4::Label::new(Some("Perfiles"))));
    notebook.append_page(&fastfetch, Some(&gtk4::Label::new(Some("Fastfetch"))));
    notebook.append_page(&wallpapers, Some(&gtk4::Label::new(Some("Wallpapers"))));

    window.set_child(Some(&notebook));
    window.present();
}
