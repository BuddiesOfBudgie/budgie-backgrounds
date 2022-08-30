config = configuration_data()
config.set('prefix', path_prefix)

gnome_backgrounds_dir = join_paths(path_datadir, 'gnome-background-properties')
configure_file(
    input: 'budgie-backgrounds.xml.in',
    output: 'budgie-backgrounds.xml',
    configuration: config,
    install_dir: gnome_backgrounds_dir,
)
