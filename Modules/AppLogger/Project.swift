import ProjectDescription
import ProjectDescriptionHelpers
import DependencyHelper

let project = Project.makeModule(
    name: "AppLogger",
    platform: .iOS,
    product: .staticFramework,
    dependencies: [
        .Module.thirdPartyLib
    ]
)
