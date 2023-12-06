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
            bundleId: "\(SharingOrganizationName).iOS.application",
            deploymentTarget: .iOS(
                targetVersion: "16.0",
                devices: [.iphone, .ipad]
            ),
            infoPlist: .file(path: "SuportingFile/Info.plist"),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            entitlements: Path("SuportingFile/Sharing-iOS.entitlements"),
            dependencies: [
                .Project.appFlow,
                .SPM.FCM
            ]
        )
    ]
)
