use gtk4::prelude::*;
use gtk4::{Box, Button, Label, ScrolledWindow, StringList, DropDown};
use crate::utils::scanner::{scan_designs, AppDesign};

pub fn build() -> Box {
    let container = Box::new(gtk4::Orientation::Vertical, 12);
    container.set_margin_top(16);
    container.set_margin_bottom(16);
    container.set_margin_start(16);
    container.set_margin_end(16);

    let title = Label::new(Some("Diseños por aplicación"));
    title.add_css_class("title");
    container.append(&title);

    let scrolled = ScrolledWindow::new();
    scrolled.set_policy(gtk4::PolicyType::Never, gtk4::PolicyType::Automatic);
    scrolled.set_hexpand(true);
    scrolled.set_vexpand(true);

    let list = Box::new(gtk4::Orientation::Vertical, 10);
    scrolled.set_child(Some(&list));

    let apps = scan_designs("/home/nv/.hypr-files");

    for app in &apps {
        let row = create_design_row(app);
        list.append(&row);
    }

    container.append(&scrolled);

    let apply_btn = Button::with_label("Aplicar cambios");
    apply_btn.add_css_class("apply-btn");
    apply_btn.set_hexpand(true);
    container.append(&apply_btn);

    container
}

fn create_design_row(app: &AppDesign) -> Box {
    let row = Box::new(gtk4::Orientation::Horizontal, 10);
    row.set_halign(gtk4::Align::Fill);

    let name = Label::new(Some(&app.name));
    name.set_width_chars(15);
    name.set_xalign(0.0);
    name.add_css_class("app-name");
    row.append(&name);

    // Convertir Vec<String> a Vec<&str>
    let items: Vec<&str> = app.available.iter().map(|s| s.as_str()).collect();
    let string_list = StringList::new(&items);

    let dropdown = DropDown::new(Some(string_list), None::<&gtk4::Expression>);
    dropdown.set_selected(0);
    dropdown.set_hexpand(true);
    dropdown.add_css_class("design-dropdown");
    row.append(&dropdown);

    row
}