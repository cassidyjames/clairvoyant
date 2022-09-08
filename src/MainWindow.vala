/*
* Copyright © 2018–2020 Cassidy James Blaede (https://cassidyjames.com)
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

public class MainWindow : Gtk.Window {
    private ContentStack stack;

    public MainWindow (Gtk.Application application) {
        Object (
            application: application,
            icon_name: "com.github.cassidyjames.clairvoyant",
            resizable: false,
            title: _("Clairvoyant")
        );
    }

    construct {
        var header = new Gtk.HeaderBar ();
        // header.show_close_button = true;
        header.add_css_class ("titlebar");
        header.add_css_class ("default-decoration");
        header.add_css_class ("flat");

        var randomize_button = new Gtk.Button.from_icon_name (
            "dialog-question-symbolic"
        );
        randomize_button.tooltip_text = _("Ask Again");

        var gtk_settings = Gtk.Settings.get_default ();

        stack = new ContentStack ();

        var context = get_style_context ();
        context.add_class ("clairvoyant");
        context.add_class ("rounded");
        context.add_class ("flat");

        randomize_button.clicked.connect (() => randomize_fortune (stack) );

        header.pack_end (randomize_button);

        set_titlebar (header);
        set_child (stack);

        stack.realize.connect (() => {
           randomize_fortune (stack, true);
        });
    }

    private void randomize_fortune (
        ContentStack stack,
        bool allow_current = false
    ) {
        int rand = Random.int_range (1, 21);
        int current = int.parse (stack.stack.visible_child_name);

        if (allow_current || rand != current) {
            stack.stack.visible_child_name = rand.to_string ();
            return;
        }

        randomize_fortune (stack);
    }

    // public override bool configure_event (Gdk.EventConfigure event) {
    //     int root_x, root_y;
    //     get_position (out root_x, out root_y);
    //     Clairvoyant.settings.set_int ("window-x", root_x);
    //     Clairvoyant.settings.set_int ("window-y", root_y);

    //     return base.configure_event (event);
    // }
}
