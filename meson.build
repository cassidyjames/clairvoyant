project ('com.github.cassidyjames.clairvoyant', 'vala', 'c')

gnome = import ('gnome')
i18n = import ('i18n')

add_global_arguments ('-DGETTEXT_PACKAGE="' + meson.project_name () + '"', language:'c')

executable(
    meson.project_name (),
    'src/Application.vala',
    'src/Content.vala',
    'src/MainWindow.vala',
    dependencies: [
        dependency ('gee-0.8'),
        dependency ('glib-2.0'),
        dependency ('gtk+-3.0')
    ],
    install: true
)
subdir ('data')

