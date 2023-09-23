import ProjectDescription
import ProjectDescriptionHelpers
import DependencyHelper

let project = Project.makeModule(
    name: "AppFlow",
    platform: .iOS,
    product: .staticFramework,
    dependencies: [
        .Project.presentation,
        .Project.data
    ]
)
