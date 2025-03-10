// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "map_plugin",
    platforms: [
        .iOS("15.0")
    ],
    products: [
        .library(name: "map-plugin", targets: ["map_plugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/maplibre/maplibre-gl-native-distribution", .upToNextMinor(from: "6.12.1")),
    ],
    targets: [
        .target(
            name: "map_plugin",
            dependencies: [
                .product(name: "MapLibre", package: "maplibre-gl-native-distribution"),
            ],
            cSettings: [
                .headerSearchPath("include/maplibre_ios"),
            ]
        )
    ]
)
