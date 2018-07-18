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
            title = "It is certain.",
            result = "positive"
        },
        Content () {
            title = "It is decidedly so.",
            result = "positive"
        },
        Content () {
            title = "Without a doubt.",
            result = "positive"
        },
        Content () {
            title = "Yes—definitely.",
            result = "positive"
        },
        Content () {
            title = "You may rely on it.",
            result = "positive"
        },
        Content () {
            title = "As I see it, yes.",
            result = "positive"
        },
        Content () {
            title = "Most likely.",
            result = "positive"
        },
        Content () {
            title = "Outlook good.",
            result = "positive"
        },
        Content () {
            title = "Yes.",
            result = "positive"
        },
        Content () {
            title = "Signs point to yes.",
            result = "positive"
        },
        Content () {
            title = "Don't count on it.",
            result = "negative"
        },
        Content () {
            title = "My reply is no.",
            result = "negative"
        },
        Content () {
            title = "My sources say no.",
            result = "negative"
        },
        Content () {
            title = "Outlook not so good.",
            result = "negative"
        },
        Content () {
            title = "Very doubtful.",
            result = "negative"
        },
        Content () {
            title = "Reply hazy, try again.",
            result = "neutral"
        },
        Content () {
            title = "Ask again later.",
            result = "neutral"
        },
        Content () {
            title = "Better not tell you now.",
            result = "neutral"
        },
        Content () {
            title = "Cannot predict now.",
            result = "neutral"
        },
        Content () {
            title = "Concentrate and ask again.",
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

