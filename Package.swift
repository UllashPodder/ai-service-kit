// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "AIServiceKit",
    platforms: [
        .iOS(.v18),
        .macOS(.v14),
    ],
    products: [
        .library(name: "AIServiceKit",       targets: ["AIServiceKit"]),
        .library(name: "AIServiceKitWhisper", targets: ["AIServiceKitWhisper"]),
        .library(name: "AIServiceKitMLX",     targets: ["AIServiceKitMLX"]),
    ],
    dependencies: [
        .package(url: "https://github.com/argmaxinc/WhisperKit", branch: "main"),
    ],
    targets: [
        .target(
            name: "AIServiceKit"
        ),
        .target(
            name: "AIServiceKitWhisper",
            dependencies: [
                "AIServiceKit",
                .product(name: "WhisperKit", package: "WhisperKit"),
            ]
        ),
        .target(
            name: "AIServiceKitMLX",
            dependencies: ["AIServiceKit"]
        ),
        .testTarget(
            name: "AIServiceKitTests",
            dependencies: ["AIServiceKit"]
        ),
    ],
    swiftLanguageModes: [.v6]
)

