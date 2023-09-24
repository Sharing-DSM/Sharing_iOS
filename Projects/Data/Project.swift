import ProjectDescription
import ProjectDescriptionHelpers
import DependencyHelper

let project = Project.makeModule(
    name: "Data",
    platform: .iOS,
    product: .staticFramework,
    dependencies: [
        .Project.domain,
        .Module.network
    ]
)
