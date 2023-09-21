import ProjectDescription
import ProjectDescriptionHelpers
import DependencyHelper

let project = Project.makeModule(
    name: "SharingFlow",
    platform: .iOS,
    product: .staticLibrary,
    dependencies: [
        .Module.thiredPartyLib
    ]
)
