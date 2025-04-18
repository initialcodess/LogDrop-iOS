// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "LogDrop",
    products: [
        .library(
            name: "LogDropSDK",
            targets: ["LogDropSDK"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "LogDropSDK",
            path: "Frameworks/LogDropSDK.xcframework"
        )
    ]
)
