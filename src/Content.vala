/*
* Copyright (c) 2018 Cassidy James Blaede (https://cassidyjames.com)
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

public class ContentStack : Gtk.Stack {
    private struct Content {
        string title;
        string result;
    }

    static Content[] content = {
        Content () {
            title = "Yes",
            result = "positive"
        },
        Content () {
            title = "No",
            result = "negative"
        },
        Content () {
            title = "Maybe",
            result = "neutral"
        }
    };

    public ContentStack () {
        Object (
            margin_bottom: 24,
            transition_type: Gtk.StackTransitionType.CROSSFADE
        );
    }

    construct {
        int i = 1;
        foreach (var fortune in content) {
            var title = new Gtk.Label (fortune.title);
            title.max_width_chars = 28;
            title.valign = Gtk.Align.END;
            title.wrap = true;
            title.xalign = 0;
            title.get_style_context ().add_class ("fortune-title");

            var grid = new Gtk.Grid ();
            grid.column_spacing = grid.row_spacing = 12;
            grid.halign = Gtk.Align.CENTER;

            grid.attach (title, 0, 0);

            add_named (grid, i.to_string ());

            i++;
        }

        var rand = Random.int_range (1, 4);
        visible_child_name = rand.to_string ();
    }
}

