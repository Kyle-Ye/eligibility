// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EligibilityCore",
    products: [
        .library(
            name: "EligibilityCore",
            targets: ["EligibilityCore"]
        ),
    ],
    targets: [
        .target(
            name: "EligibilityCore",
            path: "EligibilityCore"
        ),
        .testTarget(
            name: "EligibilityCoreTests",
            dependencies: ["EligibilityCore"],
            path: "EligibilityCoreTests"
        )
    ]
)
