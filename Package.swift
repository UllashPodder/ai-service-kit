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
        .package(url: "https://github.com/ml-explore/mlx-swift-examples", exact: "2.29.1"),
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
            dependencies: [
                "AIServiceKit",
                .product(name: "MLXLLM", package: "mlx-swift-examples"),
                .product(name: "MLXLMCommon", package: "mlx-swift-examples"),
            ]
        ),
        .testTarget(
            name: "AIServiceKitTests",
            dependencies: ["AIServiceKit"]
        ),
    ],
    swiftLanguageModes: [.v6]
)

