import UIKit
import Core
import RxFlow
import Presentation

class SignupFlow: Flow {
    public init() {}

    var root: Presentable {
        return rootPresentable
    }

    private lazy var rootPresentable = UINavigationController()

    func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? SharingStep else { return .none }
        switch step {
        case .signupRequired:
            return navigateToSignupView()
        default:
            return .none
        }
    }

    private func navigateToSignupView() -> FlowContributors {
        let signupViewController = SignupViewController(viewModel: SignupViewModel())
        rootPresentable.pushViewController(signupViewController, animated: false)
        return .none
    }
}
