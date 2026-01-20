// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "LiveActivityUtil",
  platforms: [
    .iOS(.v13)
  ],
  products: [
    .library(
      name: "LiveActivityUtil",
      targets: ["LiveActivityUtil"],
    )
  ],
  targets: [
    .target(
      name: "LiveActivityUtil"
    )
  ],
)
