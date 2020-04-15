// swift-tools-version:5.2

import PackageDescription

let settings: [CSetting] = [
    .define("PD"),
    .define("USEAPI_DUMMY"),
    .define("HAVE_UNISTD_H"),
    .define("LIBPD_EXTRA"),
    .unsafeFlags(["-fcommon"]),
]

let package = Package(
    name: "CLibPD",
    platforms: [
        .iOS(.v8)
    ],
    products: [
        .library(
            name: "CLibPD",
            targets: ["CLibPD-objc", "CLibPD-wrapper", "CLibPureData", "CLibPureData-extra"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CLibPD-objc",
            dependencies: [
                "CLibPD-wrapper"
            ],
            path: "./objc",
            cSettings: settings + [
                .headerSearchPath("../libpd_wrapper"),
                .headerSearchPath("../libpd_wrapper/util")
            ]
        ),
        .target(
            name: "CLibPD-wrapper",
            dependencies: ["CLibPureData", "CLibPureData-extra"],
            path: "./libpd_wrapper",
            cSettings: settings + [
                .headerSearchPath("../pure-data/src/include"),
                .headerSearchPath("."),
            ]
        ),
        .target(
            name: "CLibPureData",
            dependencies: [],
            path: "./pure-data/src",
            exclude: [
                "s_audio_alsa.h",
                "s_audio_alsa.c",
                "s_audio_alsamm.c",
                "s_audio_audiounit.c",
                "s_audio_esd.c",
                "s_audio_jack.c",
                "s_audio_mmio.c",
                "s_audio_oss.c",
                "s_audio_pa.c",
                "s_audio_paring.h",
                "s_audio_paring.c",
                "s_file.c",
                "s_midi_alsa.c",
                "s_midi_dummy.c",
                "s_midi_mmio.c",
                "s_midi_oss.c",
                "s_midi_pm.c",
                "s_midi.c",
                "d_fft_fftw.c",
                "s_entry.c",
                "s_watchdog.c",
                "u_pdreceive.c",
                "u_pdsend.c"
            ],
            cSettings: settings
        ),
        .target(
            name: "CLibPureData-extra",
            dependencies: [],
            path: "./pure-data/extra",
            cSettings: settings + [
                .headerSearchPath("../src"),
            ]
        ),
    ]
)
