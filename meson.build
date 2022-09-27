project(
    'com.github.cassidyjames.clairvoyant',
    'vala', 'c',
    version: '3.0.2'
)

gnome = import('gnome')
i18n = import('i18n')

add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()), language:'c')

asresources = gnome.compile_resources(
    'as-resources', 'data' / 'gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

config_data = configuration_data()

config_data.set_quoted('APP_ID', meson.project_name())
config_data.set_quoted('VERSION', meson.project_version())
config_data.set_quoted('APP_NAME', meson.project_name())
config_data.set_quoted('DEVELOPER', 'Cassidy James Blaede')

config_file = configure_file(
    input: 'src/Config.vala.in',
    output: '@BASENAME@',
    configuration: config_data
)

executable(
    meson.project_name(),
    'src' / 'Application.vala',
    'src' / 'FortuneLabel.vala',
    'src' / 'MainWindow.vala',
    asresources,
    config_file,
    dependencies: [
        dependency('gtk4'),
        dependency('libadwaita-1'),
    ],
    install: true
)

subdir('data')
subdir('po')

meson.add_install_script('meson' / 'post_install.py')
