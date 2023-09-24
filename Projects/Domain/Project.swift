import ProjectDescription
import ProjectDescriptionHelpers
import DependencyHelper

let project = Project.makeModule(
    name: "Domain",
    platform: .iOS,
    product: .staticFramework,
    dependencies: [
        .Project.core
    ]
)
