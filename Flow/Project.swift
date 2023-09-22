import ProjectDescription
import ProjectDescriptionHelpers
import DependencyHelper

let project = Project.makeModule(
    name: "Flow",
    platform: .iOS,
    product: .staticFramework,
    dependencies: [
        .Feature.exFeature
    ]
)
