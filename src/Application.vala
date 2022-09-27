/*
* Copyright © 2018–2022 Cassidy James Blaede (https://cassidyjames.com)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 3 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Cassidy James Blaede <c@ssidyjam.es>
*/

public class Clairvoyant : Adw.Application {
    public const string RDNN = "com.github.cassidyjames.clairvoyant";
    public const string NAME = _("Clairvoyant");
    public const string DEVELOPER = "Cassidy James Blaede";
    public const string VERSION = "3.0.2";
    public const string WEBSITE = "https://cassidyjames.com";
    public const string ISSUES = "https://github.com/cassidyjames/clairvoyant/issues";
    public const string COPYRIGHT = "© 2018–2022 Cassidy James Blaede";
    public const string[] ARTISTS = {
        "Micah Ilbery",
        "Cassidy James Blaede",
    };
    public const string[] DEVELOPERS = {
        "Cassidy James Blaede",
    };
    /// The translator credits. Please translate this with your name (s).
    public const string TRANSLATORS = _("translator-credits");

    public static GLib.Settings settings;

    public Clairvoyant () {
        Object (application_id: "com.github.cassidyjames.clairvoyant",
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
        var app = new Clairvoyant ();
        return app.run (args);
    }
}
