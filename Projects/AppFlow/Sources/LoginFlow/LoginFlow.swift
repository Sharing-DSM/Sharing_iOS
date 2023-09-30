import UIKit
import Presentation
import RxFlow
import Core

class LoginFlow: Flow {
    public init() {}

    var root: Presentable {
        return rootPresentable
    }

    private lazy var rootPresentable = UINavigationController()

    func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? SharingStep else { return .none }
        switch step {
        case .loginRequired:
            return navigateToLoginView()
        default:
            return .none
        }
    }

    private func navigateToLoginView() -> FlowContributors {
        let loginViewController = LoginViewController()
        rootPresentable.pushViewController(loginViewController, animated: false)
        return .none
    }
}
