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

public class MainWindow : Adw.Window {
    private FortuneLabel fortune_label;

    public MainWindow (Gtk.Application application) {
        Object (
            application: application,
            icon_name: APP_ID,
            resizable: false,
            title: Clairvoyant.NAME
        );
    }

    construct {
        var about_button = new Gtk.Button.from_icon_name ("about-symbolic") {
            tooltip_text = _("About")
        };

        var about_window = new Adw.AboutWindow () {
            transient_for = this,

            application_icon = APP_ID,
            application_name = Clairvoyant.NAME,
            developer_name = Clairvoyant.DEVELOPER,
            version = VERSION,

            website = "https://cassidyjames.com",
            issue_url = "https://github.com/cassidyjames/clairvoyant/issues",

            // Credits
            developers = { Clairvoyant.DEVELOPER },
            artists = {
                "Micah Ilbery",
                Clairvoyant.DEVELOPER,
            },
            /// The translator credits. Please translate this with your name(s).
            translator_credits = _("translator-credits"),

            // Legal
            copyright = "© 2018–2022 %s".printf (Clairvoyant.DEVELOPER),
            license_type = Gtk.License.GPL_3_0,
        };

        var header = new Gtk.HeaderBar () {
            title_widget = new Gtk.Label (null)
        };
        header.add_css_class ("flat");
        header.pack_start (about_button);

        fortune_label = new FortuneLabel ();

        var ask_button = new Gtk.Button.with_label (_("Ask Again")) {
            halign = Gtk.Align.CENTER
        };
        ask_button.add_css_class ("pill");

        var main_layout = new Gtk.Box (Gtk.Orientation.VERTICAL, 24) {
            margin_bottom = 48
        };
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
        int rand = Random.int_range (1, 21);
        int current = int.parse (fortune_label.stack.visible_child_name);

        if (allow_current || rand != current) {
            fortune_label.stack.visible_child_name = rand.to_string ();
            return;
        }

        randomize_fortune (fortune_label);
    }
}
