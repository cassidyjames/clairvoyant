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
            title = _("It is certain."),
            result = "positive"
        },
        Content () {
            title = _("It is decidedly so."),
            result = "positive"
        },
        Content () {
            title = _("Without a doubt."),
            result = "positive"
        },
        Content () {
            title = _("Yes—definitely."),
            result = "positive"
        },
        Content () {
            title = _("You may rely on it."),
            result = "positive"
        },
        Content () {
            title = _("As I see it, yes."),
            result = "positive"
        },
        Content () {
            title = _("Most likely."),
            result = "positive"
        },
        Content () {
            title = _("Outlook good."),
            result = "positive"
        },
        Content () {
            title = _("Yes."),
            result = "positive"
        },
        Content () {
            title = _("Signs point to yes."),
            result = "positive"
        },
        Content () {
            title = _("Don't count on it."),
            result = "negative"
        },
        Content () {
            title = _("My reply is no."),
            result = "negative"
        },
        Content () {
            title = _("My sources say no."),
            result = "negative"
        },
        Content () {
            title = _("Outlook not so good."),
            result = "negative"
        },
        Content () {
            title = _("Very doubtful."),
            result = "negative"
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
            margin: 24,
            margin_bottom: 48,
            transition_type: Gtk.StackTransitionType.CROSSFADE
        );
    }

    construct {
        int i = 1;
        foreach (var fortune in content) {
            var label = new Gtk.Label (fortune.title);
            label.get_style_context ().add_class ("fortune");
            label.get_style_context ().add_class (fortune.result);

            var grid = new Gtk.Grid ();
            grid.column_spacing = grid.row_spacing = 12;
            grid.halign = Gtk.Align.CENTER;

            grid.attach (label, 0, 0);

            add_named (grid, i.to_string ());

            i++;
        }

        var rand = Random.int_range (1, 21);
        visible_child_name = rand.to_string ();
    }
}

