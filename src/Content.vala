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

public class ContentStack : Gtk.Box {
    public Gtk.Stack stack;

    private struct Content {
        string title;
        string result;
    }

    static Content[] content = {
        Content () {
            title = _("It is certain."),
            result = "success"
        },
        Content () {
            title = _("It is decidedly so."),
            result = "success"
        },
        Content () {
            title = _("Without a doubt."),
            result = "success"
        },
        Content () {
            title = _("Yes—definitely."),
            result = "success"
        },
        Content () {
            title = _("You may rely on it."),
            result = "success"
        },
        Content () {
            title = _("As I see it, yes."),
            result = "success"
        },
        Content () {
            title = _("Most likely."),
            result = "success"
        },
        Content () {
            title = _("Outlook good."),
            result = "success"
        },
        Content () {
            title = _("Yes."),
            result = "success"
        },
        Content () {
            title = _("Signs point to yes."),
            result = "success"
        },
        Content () {
            title = _("Don't count on it."),
            result = "error"
        },
        Content () {
            title = _("My reply is no."),
            result = "error"
        },
        Content () {
            title = _("My sources say no."),
            result = "error"
        },
        Content () {
            title = _("Outlook not so good."),
            result = "error"
        },
        Content () {
            title = _("Very doubtful."),
            result = "error"
        },
        Content () {
            title = _("Reply hazy, try again."),
            result = "neutral"
        },
        Content () {
            title = _("Ask again later."),
            result = "neutral"
        },
        Content () {
            title = _("Better not tell you now."),
            result = "neutral"
        },
        Content () {
            title = _("Cannot predict now."),
            result = "neutral"
        },
        Content () {
            title = _("Concentrate and ask again."),
            result = "neutral"
        }
    };

    public ContentStack () {
        Object (
            margin_top: 24,
            margin_end: 24,
            margin_bottom: 48,
            margin_start: 24
        );
    }

    construct {
        stack = new Gtk.Stack () {
            transition_type = Gtk.StackTransitionType.CROSSFADE,
        };

        int i = 1;
        foreach (var fortune in content) {
            var label = new Gtk.Label (fortune.title);
            label.add_css_class ("fortune");
            label.add_css_class (fortune.result);

            var grid = new Gtk.Grid ();
            grid.column_spacing = grid.row_spacing = 12;
            grid.halign = Gtk.Align.CENTER;

            grid.attach (label, 0, 0);

            stack.add_named (grid, i.to_string ());

            i++;
        }

        var rand = Random.int_range (1, 21);
        stack.visible_child_name = rand.to_string ();

        append (stack);
    }
}
