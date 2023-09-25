project(
    'com.github.cassidyjames.clairvoyant',
    'vala', 'c',
    version: '3.1.2',
    meson_version: '>=0.58',
)

gnome = import('gnome')
i18n = import('i18n')

add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()), language:'c')

add_project_arguments(
  ['--vapidir', meson.current_source_dir() / 'vapi'],
  language: 'vala'
)

conf = configuration_data()
# Get the package data directory under Meson
pkgdatadir = join_paths([
  get_option('prefix'),
  get_option('datadir'),
  meson.project_name()
])
conf.set_quoted('APP_ID', meson.project_name())
conf.set_quoted('VERSION', meson.project_version())
conf.set_quoted('PKGDATADIR', pkgdatadir)
conf.set_quoted('LOCALEDIR', join_paths(get_option('prefix'), get_option('localedir')))

# Other configs
conf.set_quoted('GETTEXT_PACKAGE', meson.project_name())
add_global_arguments('-DDATADIR="' + get_option('datadir') + '"', language: 'c')
configure_file(output: 'config.h', configuration: conf)
config_h_dir = include_directories('.')

# Arguments for C
c_args = [
  '-include', 'config.h',
  '-w'
]

# Arguments for Vala
vala_args = ['--target-glib=2.50', meson.project_source_root() + '/src/config.vapi']

asresources = gnome.compile_resources(
  'as-resources', 'data' / 'gresource.xml',
  source_dir: 'data',
  c_name: 'as'
)

config_file = configure_file(
  input: 'src/Config.vala.in',
  output: '@BASENAME@',
  configuration: conf
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
    dependency('libadwaita-1', version: '>=1.4'),
  ],
  c_args: c_args, vala_args: vala_args,
  install: true
)

subdir('data')
subdir('po')
