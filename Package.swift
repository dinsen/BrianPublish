// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "Brian",
    products: [
        .executable(name: "Brian", targets: ["Brian"])
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish", from: "0.2.0"),
        .package(url: "https://github.com/johnsundell/splashpublishplugin", from: "0.1.0"),
//        .package(path: "../BrianPublishTheme")
        .package(url: "https://github.com/Dinsen/BrianPublishTheme", from: "0.1.0")
    ],
    targets: [
        .target(
            name: "Brian",
            dependencies: ["Publish",
                           "SplashPublishPlugin",
                           "BrianPublishTheme"]
        )
    ]
)
