// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "RegexMatches",
    platforms: [
        .macOS(.v13),
    ],
    products: [
        .library(name: "RegexMatches", targets: ["RegexMatches"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "RegexMatches", dependencies: []),
        .testTarget(name: "RegexMatchesTests", dependencies: ["RegexMatches"]),
    ]
)
