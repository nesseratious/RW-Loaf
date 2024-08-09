// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "Loaf",
    platforms: [
        .iOS(.v16), .macCatalyst(.v16)
    ],
    products: [
        .library(
            name: "Loaf",
            targets: ["Loaf"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Loaf",
            dependencies: [])
    ]
)
