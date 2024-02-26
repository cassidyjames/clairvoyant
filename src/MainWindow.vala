/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2018–2024 Cassidy James Blaede <c@ssidyjam.es>
 */

public class MainWindow : Adw.Window {
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
            "/com/github/cassidyjames/clairvoyant/metainfo.xml", VERSION
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

        var banner = new Adw.Banner (_("Unsupported version of this app")) {
            button_label = _("_Learn More…"),
            revealed = true
        };

        string[] env = Environ.get ();
        try {
            banner.revealed = (
                Clairvoyant.settings.get_int64 ("last-used") < new DateTime.now_utc ().to_unix () - 86400 &&
                Clairvoyant.settings.get_int64 ("last-used") != int64.MIN /*&& (
                    ! Xdp.Portal.running_under_flatpak () ||
                    Xdp.Portal.running_under_snap () ||
                    Environ.get_variable (env, "FLATPAK_ID") != APP_ID ||
                    Environ.get_variable (env, "APPIMAGE") != null
                )*/
            );
        } catch (Error e) {
            critical ("Unable to detect sandbox");
        }

        var main_layout = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
        main_layout.append (header);
        main_layout.append (fortune_label);
        main_layout.append (ask_button);
        main_layout.append (banner);

        var window_handle = new Gtk.WindowHandle () {
            child = main_layout
        };

        set_content (window_handle);

        fortune_label.realize.connect (() => {
           randomize_fortune (fortune_label, true);
        });

        about_button.clicked.connect (() => about_window.present () );
        ask_button.clicked.connect (() => randomize_fortune (fortune_label) );

        banner.button_clicked.connect (() => {
           try {
                new Gtk.UriLauncher (about_window.website + "#only-on-flathub").launch.begin (null, null);
            } catch (Error e) {
                critical ("Unable to open link");
            }
        });

        close_request.connect (() => {
            Clairvoyant.settings.set_int64 ("last-used", new DateTime.now_utc ().to_unix ());
            critical("last-used after checking: %" + int64.FORMAT, Clairvoyant.settings.get_int64("last-used"));
            return Gdk.EVENT_PROPAGATE;
        });
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
