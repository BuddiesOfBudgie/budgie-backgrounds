backgrounds = [
    'apollo-11-earth.jpg',
    'lake-sherburne.jpg',
    'saturnian-profile.jpg',
    'ufo-galaxy.jpg',
    'beacon-street-sunset.jpg',
    'perched-osprey.jpg',
    'canyon-wren.jpg',
    'oakland-zoo-otters.jpg',
    'abstract-spiral.jpg',
    'kitten-on-lawn.jpg',
    'accelerated-green.jpg',
    'roman-colosseum.jpg',
    'piazza-gae-aulenti.jpg',
    'high-trestle-trail.jpg',
    'tea-gardens.jpg',
    'geo-forest.jpg',
    'valley-coral.jpg',
    'valley-midnight.jpg',
    'waves-midnight.jpg',
    'waves-slate.jpg',
    'solaris-grapes.jpg',
    'blue-periwinkle.jpg',
    'dragonfly-on-lavender.jpg',
    'extreme-desert-hike.jpg',
    'casa-mila.jpg',
    'ocean-waves.jpg',
    'motherboard-circuits.jpg',
    'singaporean-cityscape.jpg',
    'orange-hallway.jpg',
    'spiral-firework.jpg',
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
