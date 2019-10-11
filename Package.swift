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
        )
    ],
    dependencies: [
      .package(url: "https://github.com/e-sites/URITemplate.swift.git", .branch("master"))
    ],
    targets: [
        .target(
            name: "Mockingjay",
            dependencies: [ "URITemplate" ],
            path: "Sources"
        ),
        .testTarget(
          name: "MockingjayTests",
          dependencies: [ "Mockingjay" ],
          path: "Tests/MockingjayTests"
        )
    ],
    swiftLanguageVersions: [ .v4, .v5 ]
)
