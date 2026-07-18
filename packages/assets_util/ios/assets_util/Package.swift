// swift-tools-version: 6.2

import PackageDescription

let package = Package(
  name: "assets_util",
  platforms: [
    .iOS(.v13)
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
    )
  ]
)
