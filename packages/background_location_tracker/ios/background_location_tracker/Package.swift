// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "background_location_tracker",
    platforms: [
        .iOS("14.0"),
    ],
    products: [
        .library(
            name: "background-location-tracker",
            targets: ["background_location_tracker"]
        ),
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
    ],
    targets: [
        .target(
            name: "background_location_tracker",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
            ]
        ),
    ]
)
