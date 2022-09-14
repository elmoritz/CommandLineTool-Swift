// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

fileprivate extension String {
    static let Run = "Run"
    static let App = "App"
    static let CommandLineTool = "CommandLineTool"
}

let package = Package(
    name: "CommandLineTool",
    platforms: [
        .macOS(.v12)
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: .App,
            dependencies: [
            ]
        ),
        .executableTarget(name: .Run,
                          dependencies: [.target(name: .App)]
                         ),
        .testTarget(
            name: "CommandLineToolTests",
            dependencies: [.target(name: .App)]),
    ]
)
