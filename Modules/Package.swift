// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "Core-Networking", targets: ["Core-Networking"]),
        .library(name: "Feature-WordDefinition", targets: ["Feature-WordDefinition"]),
        .library(name: "Feature-Thesaurus", targets: ["Feature-Thesaurus"]),
        .library(name: "Root-Elements", targets: ["Root-Elements"]),
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
        .target(
            name: "Feature-WordDefinition",
            dependencies: [
                "Core-Networking",
                "Root-Elements",
                "Feature-Thesaurus"
            ]
        ),
        .target(
            name: "Feature-Thesaurus",
            dependencies: [
                "Core-Networking",
                "Root-Elements"
            ]
        ),
        .target(
            name: "Root-Elements",
            dependencies: []
        )
    ]
)
