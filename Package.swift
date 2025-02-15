// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "SpotifyNowPlaying",
    platforms: [
        .macOS(.v11)
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "SpotifyNowPlaying",
            dependencies: []
        ),
    ]
)
