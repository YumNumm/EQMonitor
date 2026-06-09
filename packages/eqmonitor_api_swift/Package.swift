// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "EQMonitorAPI",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
    ],
    products: [
        .library(
            name: "EQMonitorAPI",
            targets: ["EQMonitorAPI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-openapi-runtime", from: "1.8.2"),
        .package(url: "https://github.com/apple/swift-openapi-urlsession", from: "1.1.0"),
    ],
    targets: [
        .target(
            name: "EQMonitorAPI",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ]
        ),
        .testTarget(
            name: "EQMonitorAPITests",
            dependencies: ["EQMonitorAPI"],
            resources: [.copy("fixtures")]
        ),
    ]
)
