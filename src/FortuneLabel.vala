/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2018–2022 Cassidy James Blaede <c@ssidyjam.es>
 */

public class FortuneLabel : Gtk.Box {
    public Gtk.Stack stack;

    private struct Content {
        string title;
        string css_class;
    }

    static Content[] content = {
        Content () {
            title = _("It is certain."),
            css_class = "success"
        },
        Content () {
            title = _("It is decidedly so."),
            css_class = "success"
        },
        Content () {
            title = _("Without a doubt."),
            css_class = "success"
        },
        Content () {
            title = _("Yes—definitely."),
            css_class = "success"
        },
        Content () {
            title = _("You may rely on it."),
            css_class = "success"
        },
        Content () {
            title = _("As I see it, yes."),
            css_class = "success"
        },
        Content () {
            title = _("Most likely."),
            css_class = "success"
        },
        Content () {
            title = _("Outlook good."),
            css_class = "success"
        },
        Content () {
            title = _("Yes."),
            css_class = "success"
        },
        Content () {
            title = _("Signs point to yes."),
            css_class = "success"
        },
        Content () {
            title = _("Yep!"),
            css_class = "success"
        },
        Content () {
            title = _("Absolutely!"),
            css_class = "success"
        },
        Content () {
            title = _("You bet!"),
            css_class = "success"
        },
        Content () {
            title = _("Confirmed."),
            css_class = "success"
        },
        Content () {
            title = _("Don’t count on it."),
            css_class = "error"
        },
        Content () {
            title = _("My reply is no."),
            css_class = "error"
        },
        Content () {
            title = _("My sources say no."),
            css_class = "error"
        },
        Content () {
            title = _("Outlook not so good."),
            css_class = "error"
        },
        Content () {
            title = _("Very doubtful."),
            css_class = "error"
        },
        Content () {
            title = _("Naw."),
            css_class = "error"
        },
        Content () {
            title = _("I’ve got a bad feeling about this…"),
            css_class = "error"
        },
        Content () {
            title = _("Reply hazy, try again."),
            css_class = "warning"
        },
        Content () {
            title = _("Ask again later."),
            css_class = "warning"
        },
        Content () {
            title = _("Better not tell you now."),
            css_class = "warning"
        },
        Content () {
            title = _("Cannot predict now."),
            css_class = "warning"
        },
        Content () {
            title = _("Concentrate and ask again."),
            css_class = "warning"
        },
        Content () {
            title = _("Impossible to see, the future is."),
            css_class = "warning"
        },
        Content () {
            title = _("404 Answer Not Found"),
            css_class = "warning"
        },
    };

    public FortuneLabel () {
        Object ();
    }

    construct {
        stack = new Gtk.Stack () {
            transition_type = Gtk.StackTransitionType.CROSSFADE,
        };

        int i = 1;
        foreach (var fortune in content) {
            var title_label = new Gtk.Label (fortune.title) {
                wrap = true
            };
            title_label.add_css_class ("title-1");
            title_label.add_css_class (fortune.css_class);

            var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0) {
                margin_start = 24,
                margin_end = 24,
            };
            box.halign = Gtk.Align.CENTER;
            box.append (title_label);

            stack.add_named (box, i.to_string ());

            i++;
        }

        var rand = Random.int_range (1, 29);
        stack.visible_child_name = rand.to_string ();

        append (stack);
    }
}
