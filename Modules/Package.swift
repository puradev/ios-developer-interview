// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "Core-Networking", targets: ["Core-Networking"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Core-Networking",
            dependencies: []
        ),
        .testTarget(
            name: "Core-Networking-Tests",
            dependencies: ["Core-Networking"]
        ),
    ]
)
