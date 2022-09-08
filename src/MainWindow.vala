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
            icon_name: "com.github.cassidyjames.clairvoyant",
            resizable: false,
            title: _("Clairvoyant")
        );
    }

    construct {
        var header = new Gtk.HeaderBar () {
            title_widget = new Gtk.Label (null)
        };
        header.add_css_class ("flat");

        fortune_label = new FortuneLabel ();

        var ask_button = new Gtk.Button.with_label (_("Ask Again")) {
            halign = Gtk.Align.CENTER
        };
        ask_button.add_css_class ("pill");

        ask_button.clicked.connect (() => randomize_fortune (fortune_label) );

        var main_layout = new Gtk.Box (Gtk.Orientation.VERTICAL, 24) {
            margin_bottom = 48
        };
        main_layout.append (header);
        main_layout.append (fortune_label);
        main_layout.append (ask_button);

        var window_handle = new Gtk.WindowHandle () ;
        window_handle.child = main_layout;

        set_content (window_handle);

        fortune_label.realize.connect (() => {
           randomize_fortune (fortune_label, true);
        });
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
