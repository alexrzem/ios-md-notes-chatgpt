// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MarkdownNotes",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .iOSApplication(
            name: "MarkdownNotes",
            targets: ["AppModule"],
            bundleIdentifier: "com.example.MarkdownNotes",
            teamIdentifier: "ABCDE12345",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .assetCatalog(name: "AppIcon"),
            accentColor: .assetCatalog(name: "AccentColor"),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeLeft,
                .landscapeRight,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ]
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: "Sources",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
