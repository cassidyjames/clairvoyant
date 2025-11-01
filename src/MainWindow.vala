/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2018–2025 Cassidy James Blaede <c@ssidyjam.es>
 */

public class MainWindow : Adw.ApplicationWindow {
    private FortuneLabel fortune_label;

    public MainWindow (Gtk.Application application) {
        Object (
            application: application,
            icon_name: APP_ID,
            resizable: false
        );
    }

    construct {
        var about_button = new Gtk.Button.from_icon_name ("about-symbolic") {
            tooltip_text = _("About")
        };
        about_button.add_css_class ("dim-label");

        var about_window = new Adw.AboutWindow.from_appdata (
            "/com/cassidyjames/clairvoyant/metainfo.xml", VERSION
        ) {
            transient_for = this,
            hide_on_close = true,

            /// The translator credits. Please translate this with your name(s).
            translator_credits = _("translator-credits"),
        };
        about_window.copyright = "© 2018–%i %s".printf (
            new DateTime.now_local ().get_year (),
            about_window.developer_name
        );

        // Set MainWindow properties from the AppData already fetched and parsed
        // by the AboutWindow construction
        this.title = about_window.application_name;

        var header = new Gtk.HeaderBar () {
            title_widget = new Gtk.Label (null)
        };
        header.add_css_class ("flat");
        header.pack_start (about_button);

        fortune_label = new FortuneLabel () {
            margin_top = 24,
            margin_bottom = 24
        };

        var ask_button = new Gtk.Button.with_label (_("Ask Again")) {
            halign = Gtk.Align.CENTER,
            margin_bottom = 48
        };
        ask_button.add_css_class ("suggested-action");
        ask_button.add_css_class ("pill");

        var main_layout = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        main_layout.append (header);
        main_layout.append (fortune_label);
        main_layout.append (ask_button);

        var window_handle = new Gtk.WindowHandle () {
            child = main_layout
        };

        set_content (window_handle);

        fortune_label.realize.connect (() => {
           randomize_fortune (fortune_label, true);
        });

        about_button.clicked.connect (() => about_window.present () );
        ask_button.clicked.connect (() => randomize_fortune (fortune_label) );
    }

    private void randomize_fortune (
        FortuneLabel fortune_label,
        bool allow_current = false
    ) {
        int rand = Random.int_range (1, 29);
        int current = int.parse (fortune_label.stack.visible_child_name);

        if (allow_current || rand != current) {
            fortune_label.stack.visible_child_name = rand.to_string ();
            return;
        }

        randomize_fortune (fortune_label);
    }
}
