import UIKit
import RxFlow
import RxSwift
import RxCocoa
import Presentation
import Core

class ProfileFlow: Flow {

    public init() {}

    private let rootViewController = BaseNavigationController()

    var root: RxFlow.Presentable {
        return rootViewController
    }

    private let container = StepperDI.shared

    func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? SharingStep else { return  .none }
        switch step {
        case .profileRequired:
            return presentProfileView()
        default:
            return .none
        }
    }

    private func presentProfileView() -> FlowContributors {
        let profileView = ProfileViewController()

        self.rootViewController.pushViewController(profileView, animated: false)
        return .none
    }
}
