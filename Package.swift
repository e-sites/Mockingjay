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
            targets: ["Mockingjay"]
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
            name: "Mockingjay",
            dependencies: [ "URITemplate" ],
            path: "Sources/Core"
        ),
        .target(
            name: "MockingjayXCTest",
            dependencies: [ "Mockingjay" ],
            path: "Sources/XCTest"
        ),
        .testTarget(
          name: "MockingjayTests",
          dependencies: [ "MockingjayXCTest" ],
          path: "Tests/MockingjayTests"
        )
    ],
    swiftLanguageVersions: [ .v4, .v5 ]
)
