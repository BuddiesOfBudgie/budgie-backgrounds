backgrounds = [
    'abstract-spiral.jpg',
    'beacon-street-sunset.jpg',
    'blue-periwinkle.jpg',
    'canyon-wren.jpg',
    'casa-mila.jpg',
    'extreme-desert-hike.jpg',
    'high-trestle-trail.jpg',
    'lake-sherburne.jpg',
    'oakland-zoo-otters.jpg',
    'ocean-waves.jpg',
    'perched-osprey.jpg',
    'piazza-gae-aulenti.jpg',
    'roman-colosseum.jpg',
    'singaporean-cityscape.jpg',
    'tea-gardens.jpg',
    'valley-midnight.jpg',
    'waves-midnight.jpg',
]

backgrounds_dir = join_paths(path_datadir, 'backgrounds', 'budgie')

mogrify = find_program('mogrify')
jhead = find_program('jhead')

script = find_program(join_paths(meson.source_root(), 'scripts', 'optimizeImage.sh'))

optimized_background_targets = []
foreach background : backgrounds
    optimized_background_targets += custom_target(background,
        input: background,
        output: '@BASENAME@.jpg',
        command: [script, '@INPUT@', '@OUTPUT@'],
        install: true,
        install_dir: backgrounds_dir
    )
endforeach
