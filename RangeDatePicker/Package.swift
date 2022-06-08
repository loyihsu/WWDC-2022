// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RangeDatePicker",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "RangeDatePicker", targets: ["RangeDatePicker"]),
    ],
    dependencies: [

    ],
    targets: [
        .target(name: "RangeDatePicker", dependencies: [])
    ]
)
