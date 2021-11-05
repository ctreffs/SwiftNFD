// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "SwiftNFD",
    products: [
        .library(
            name: "NFD",
            targets: ["NFD"]
        ),
    ],
    targets: [
        .target(
            name: "NFD",
            dependencies: ["CNFD"]
        ),
        .target(name: "CNFD",
                exclude: ["LICENSE"],
                linkerSettings: [.linkedFramework("AppKit", .when(platforms: [.macOS]))]),
    ]
)
