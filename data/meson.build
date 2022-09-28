install_data(
  join_paths('icons', meson.project_name() + '.svg'),
  install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', 'scalable', 'apps'),
)

install_data(
  join_paths('icons', 'symbolic.svg'),
  install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', 'symbolic', 'apps'),
  rename: meson.project_name() + '-symbolic.svg'
)

i18n.merge_file(
  input: 'launcher.desktop.in',
  output: meson.project_name() + '.desktop',
  po_dir: join_paths(meson.source_root(), 'po'),
  type: 'desktop',
  install: true,
  install_dir: join_paths(get_option('datadir'), 'applications')
)

i18n.merge_file(
  input: 'metainfo.appdata.xml.in',
  output: meson.project_name() + '.metainfo.xml',
  po_dir: join_paths(meson.source_root(), 'po'),
  type: 'xml',
  install: true,
  install_dir: join_paths(get_option('datadir'), 'metainfo')
)

