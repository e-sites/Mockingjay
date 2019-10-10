// swift-tools-version:5.0

import PackageDescription
let package = Package(
    name: "MockingJay",
    platforms: [
        .iOS(.v10),
        .macOS(.v10_10),
        .tvOS(.v10)
    ],
    products: [
        .library(
            name: "MockingJay",
            targets: ["MockingJayCore"]
        ),
        .library(
            name: "MockingJayXCTest",
            targets: ["MockingJayXCTest"]
        )
    ],
    dependencies: [
      .package(url: "https://github.com/e-sites/URITemplate.swift.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "MockingJayCore",
            dependencies: [ "URITemplate" ],
            path: "Sources/Core"
        ),
        .target(
            name: "MockingJayXCTest",
            dependencies: [ "MockingJayCore" ],
            path: "Sources/XCTest"
        ),
        .testTarget(
          name: "MockingJayTests",
          dependencies: [ "MockingJayCore" ],
          path: "Tests/MockingjayTests"
        )
    ],
    swiftLanguageVersions: [ .v4, .v5 ]
)
