/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2018–2022 Cassidy James Blaede <c@ssidyjam.es>
 */

public class Clairvoyant : Adw.Application {
    public const string NAME = "Clairvoyant";
    public const string DEVELOPER = "Cassidy James Blaede";

    public static GLib.Settings settings;

    public Clairvoyant () {
        Object (application_id: APP_ID,
        flags: ApplicationFlags.FLAGS_NONE);
    }

    protected override void activate () {
        if (get_windows ().length () > 0) {
            get_windows ().data.present ();
            return;
        }

        var main_window = new MainWindow (this);
        main_window.show ();

        var quit_action = new SimpleAction ("quit", null);

        add_action (quit_action);
        set_accels_for_action ("app.quit", {"Escape"});

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
