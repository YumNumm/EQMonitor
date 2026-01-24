// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "live_activity_util",
  platforms: [
    .iOS(.v13)
  ],
  products: [
    .library(
      name: "live_activity_util",
      targets: ["live_activity_util"]
    )
  ],
  targets: [
    .target(
      name: "live_activity_util"
    )
  ]

)
