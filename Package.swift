// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ViewKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ViewKit",
            targets: ["ViewKit"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/BaherTamer/SwiftSafeUI.git",
            .upToNextMajor(from: "1.3.0")
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ViewKit",
            dependencies: [
                .product(name: "SwiftSafeUI", package: "swiftsafeui")
            ],
            resources: [
                .process("Localizable.xcstrings"),
                .process("Media.xcassets")
            ]
        ),
        .testTarget(
            name: "ViewKitTests",
            dependencies: [
                "ViewKit"
            ]
        )
    ]
)
