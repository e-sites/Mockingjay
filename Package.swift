// swift-tools-version:5.0

import PackageDescription
let package = Package(
    name: "Mockingjay",
    platforms: [
        .iOS(.v10),
        .macOS(.v10_10),
        .tvOS(.v10)
    ],
    products: [
        .library(
            name: "Mockingjay",
            targets: ["MockingjayCore"]
        ),
        .library(
            name: "MockingjayXCTest",
            targets: ["MockingjayXCTest"]
        )
    ],
    dependencies: [
      .package(url: "https://github.com/e-sites/URITemplate.swift.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "MockingjayCore",
            dependencies: [ "URITemplate" ],
            path: "Sources/Core"
        ),
        .target(
            name: "MockingjayXCTest",
            dependencies: [ "MockingjayCore" ],
            path: "Sources/XCTest"
        ),
        .testTarget(
          name: "MockingjayTests",
          dependencies: [ "MockingjayCore" ],
          path: "Tests/MockingjayTests"
        )
    ],
    swiftLanguageVersions: [ .v4, .v5 ]
)
