project(
    'com.github.cassidyjames.clairvoyant',
    'vala', 'c',
    version: '3.0.1'
)

gnome = import('gnome')
i18n = import('i18n')

add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()), language:'c')

asresources = gnome.compile_resources(
    'as-resources', 'data' / 'gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

executable(
    meson.project_name(),
    'src' / 'Application.vala',
    'src' / 'FortuneLabel.vala',
    'src' / 'MainWindow.vala',
    asresources,
    dependencies: [
        dependency('gtk4'),
        dependency('libadwaita-1'),
    ],
    install: true
)

subdir('data')
subdir('po')

meson.add_install_script('meson' / 'post_install.py')
