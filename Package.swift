// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "BlazejDev",
    products: [
        .executable(
            name: "BlazejDev",
            targets: ["BlazejDev"]
        )
    ],
    dependencies: [
        .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.7.0")
    ],
    targets: [
        .target(
            name: "BlazejDev",
            dependencies: ["Publish"]
        )
    ]
)