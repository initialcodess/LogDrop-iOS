// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "LogDrop",
    platforms: [.iOS("15.0")],
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