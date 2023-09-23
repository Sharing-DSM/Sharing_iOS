import ProjectDescription
import ProjectDescriptionHelpers
import DependencyHelper

let project = Project.makeModule(
    name: "Network",
    platform: .iOS,
    product: .staticFramework,
    dependencies: [
        .Project.core
    ]
)
