import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "Sharing_iOS",
    organizationName: sharingDSMOrganizationName,
    targets: [
        Target(
            name: "Sharing_iOS",
            platform: .iOS,
            product: .app,
            bundleId: "com.DSM",
            deploymentTarget: .iOS(
                   targetVersion: "15.0",
                   devices: .iphone
               ),
            infoPlist: .file(path: Path("SupportingFiles/Info.plist")),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
            ]
        )
    ]
)
