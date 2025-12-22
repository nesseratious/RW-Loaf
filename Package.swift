// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoafWrapper",
    platforms: [
        .iOS(.v15), 
        .macCatalyst(.v15)
    ],
    products: [
        .library(
            name: "LoafWrapper",
            targets: ["LoafWrapper"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "LoafWrapper",
            dependencies: [])
    ]
)
