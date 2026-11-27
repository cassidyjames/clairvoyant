install_data(
  join_paths('icons', 'app.svg'),
  install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', 'scalable', 'apps'),
  rename: meson.project_name() + '.svg'
)

install_data(
  join_paths('icons', 'symbolic.svg'),
  install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', 'symbolic', 'apps'),
  rename: meson.project_name() + '-symbolic.svg'
)

desktop_file = i18n.merge_file(
  input: 'launcher.desktop.in',
  output: meson.project_name() + '.desktop',
  po_dir: join_paths(meson.project_source_root(), 'po'),
  type: 'desktop',
  install: true,
  install_dir: join_paths(get_option('datadir'), 'applications')
)

# Validate Desktop
desktop_utils = find_program('desktop-file-validate', required: false)
if desktop_utils.found()
  test('validate-desktop', desktop_utils,
    args: [desktop_file]
  )
endif

metainfo_file = i18n.merge_file(
  input: 'metainfo.appdata.xml.in',
  output: meson.project_name() + '.metainfo.xml',
  po_dir: join_paths(meson.project_source_root(), 'po'),
  type: 'xml',
  install: true,
  install_dir: join_paths(get_option('datadir'), 'metainfo')
)

# Validate Appdata
appstreamcli = find_program('appstreamcli', required: false)
if (appstreamcli.found())
  test('validate-appdata',
    appstreamcli,
    args: ['validate', '--no-net', '--explain', metainfo_file],
    workdir: meson.current_build_dir()
  )
endif

dbus_service_file = configure_file(
  input: 'com.cassidyjames.clairvoyant.service.in',
  output: 'com.cassidyjames.clairvoyant.service',
  configuration: {
    'bindir': get_option('prefix') / get_option('bindir')
  },
  install_dir: join_paths(get_option('datadir'), 'dbus-1', 'services')
)
