import ProjectDescription
import ProjectDescriptionHelpers
import DependencyHelper

let project = Project(
    name: "Sharing-iOS",
    organizationName: SharingOrganizationName,
    targets: [
        Target(
            name: "Sharing-iOS",
            platform: .iOS,
            product: .app,
            bundleId: "\(SharingOrganizationName).iOS.app",
            deploymentTarget: .iOS(
                targetVersion: "16.0",
                devices: [.iphone, .ipad]
            ),
            infoPlist: .file(path: "SuportingFile/Info.plist"),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .Project.appFlow
            ]
        )
    ]
)
