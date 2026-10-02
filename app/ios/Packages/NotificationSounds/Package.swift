// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "NotificationSounds",
  platforms: [.iOS(.v17)],
  products: [.library(name: "NotificationSounds", targets: ["NotificationSounds"])],
  targets: [
    .target(name: "NotificationSounds"),
    .testTarget(
      name: "NotificationSoundsTests",
      dependencies: ["NotificationSounds"],
      resources: [.copy("Fixtures")]
    ),
  ],
  swiftLanguageModes: [.v5]
)
