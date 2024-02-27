/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2018–2023 Cassidy James Blaede <c@ssidyjam.es>
 */

public class Clairvoyant : Adw.Application {
    public static GLib.Settings settings;

    public Clairvoyant () {
        Object (
            application_id: APP_ID,
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    static construct {
        settings = new Settings (APP_ID);
    }

    protected override void activate () {
        if (get_windows ().length () > 0) {
            get_windows ().data.present ();
            return;
        }

        if (Clairvoyant.settings.get_int64 ("last") == int64.MIN) {
            Clairvoyant.settings.set_int64 ("last", new DateTime.now_utc ().to_unix ());
        }

        var main_window = new MainWindow (this);
        main_window.show ();

        var quit_action = new SimpleAction ("quit", null);

        add_action (quit_action);
        set_accels_for_action ("app.quit", {
            "Escape",
            "<Ctrl>Q",
            "<Ctrl>W",
        });

        quit_action.activate.connect (() => {
            if (main_window != null) {
                main_window.destroy ();
            }
        });
    }

    private static int main (string[] args) {
        Intl.bindtextdomain (Config.GETTEXT_PACKAGE, Config.LOCALEDIR);
        Intl.bind_textdomain_codeset (Config.GETTEXT_PACKAGE, "UTF-8");
        Intl.textdomain (Config.GETTEXT_PACKAGE);
        var app = new Clairvoyant ();
        return app.run (args);
    }
}
