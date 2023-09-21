import ProjectDescription
import ProjectDescriptionHelpers
import DependencyHelper

let project = Project.makeModule(
    name: "ThiredPartyLib",
    platform: .iOS,
    product: .framework,
    dependencies: [
        .SPM.KeychainSwift,
        .SPM.Kingfisher,
        .SPM.Moya,
        .SPM.RxCocoa,
        .SPM.RxFlow,
        .SPM.RxMoya,
        .SPM.RxSwift,
        .SPM.SnapKit,
        .SPM.SocketIO,
        .SPM.Then
    ]
)
