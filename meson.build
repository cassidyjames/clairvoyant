project(
    'com.github.cassidyjames.clairvoyant',
    'vala', 'c',
    version: '2.0.0'
)

gnome = import('gnome')
i18n = import('i18n')

add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()), language:'c')

executable(
    meson.project_name(),
    'src' / 'Application.vala',
    'src' / 'FortuneLabel.vala',
    'src' / 'MainWindow.vala',
    dependencies: [
        dependency('glib-2.0'),
        dependency('gtk4'),
        dependency('libadwaita-1'),
    ],
    install: true
)

subdir('data')
subdir('po')

meson.add_install_script('meson' / 'post_install.py')
