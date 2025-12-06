// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "qbcps-structures",
    // These minimum platform values come from the documentation for the structures and features used in the
    // library. It's not that I intend to build and test on these ancient versions, it's just that I'm not using
    // any language features that were introduced after the declared versions.
    platforms: [
        .iOS(.v12),
        .macCatalyst(.v13),
        .macOS(.v10_13),
        .tvOS(.v12),
        .visionOS(.v1),
        .watchOS(.v4)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "QBStructures",
            targets: ["QBStructures"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "QBStructures"
        ),
        .testTarget(
            name: "QBStructuresTests",
            dependencies: ["QBStructures"]
        ),
    ]
)
