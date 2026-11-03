// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "dfinery_plugin",
    platforms: [
        .iOS("15.0")
    ],
    products: [
        .library(name: "dfinery-plugin", targets: ["dfinery_plugin"])
    ],
    dependencies: [
        .package(url: "https://github.com/IGAWorksDev/dfinery-ios-sdk", from: "2.6.0")
    ],
    targets: [
        .target(
            name: "dfinery_plugin",
            dependencies: [
                .product(name: "DfinerySDK", package: "dfinery-ios-sdk")
            ],
            path: "Sources/dfinery_plugin"
        )
    ]
)
