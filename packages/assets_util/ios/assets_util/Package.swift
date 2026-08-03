// swift-tools-version: 6.2

import PackageDescription

let package = Package(
  name: "assets_util",
  platforms: [
    .iOS(.v13),
    // Runner's actual MACOSX_DEPLOYMENT_TARGET is 15.6
    // (app/macos/Runner.xcodeproj/project.pbxproj); SwiftPM only expresses
    // major versions, so .v15 is the closest floor.
    .macOS(.v15),
  ],
  products: [
    .library(
      name: "assets_util",
      targets: ["assets_util"]
    )
  ],
  targets: [
    .target(
      name: "assets_util"
    ),
    .testTarget(
      name: "assets_utilTests",
      dependencies: ["assets_util"]
    )
  ]
)
