// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "API",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "API",
            targets: ["API"]),
    ],
    dependencies: [
      .package(url: "https://github.com/PGSSoft/XCTestParametrizedMacro", from: "0.1.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
          name: "API"
        ),
        .testTarget(
            name: "APITests",
            dependencies: ["API", .product(name: "XCTestParametrizedMacro", package: "XCTestParametrizedMacro")]
        )
    ]
)