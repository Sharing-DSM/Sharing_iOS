import UIKit
import Presentation
import RxFlow
import Core

class AuthFlow: Flow {
    public init() {}

    var root: Presentable {
        return rootPresentable
    }

    private lazy var rootPresentable = UINavigationController().then {
        $0.navigationBar.backIndicatorImage = UIImage()
        $0.navigationBar.backIndicatorTransitionMaskImage = UIImage()
    }
    private let container = StepperDI.shared

    func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? SharingStep else { return .none }
        switch step {
        case .loginRequired:
            return navigateToLoginView()
        case .signupRequired:
            return navigateToSignupView()
        case .tabsRequired:
            return navigateToTabs()
        case .errorAlertRequired(let content):
            return presentErrorAlert(content)
        case .alertRequired(let title, let content):
            return presentDefaltAlert(title, content)
        default:
            return .none
        }
    }

    private func navigateToLoginView() -> FlowContributors {
        let viewModel = container.loginViewModel
        let loginViewController = LoginViewController(
            viewModel: viewModel
        )
        rootPresentable.pushViewController(loginViewController, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: loginViewController,
            withNextStepper: viewModel
        ))
    }

    private func navigateToSignupView() -> FlowContributors {
        let viewModel = container.signupViewModel
        let signupViewController = SignupViewController(
            viewModel: viewModel
        )
        rootPresentable.pushViewController(signupViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: signupViewController,
            withNextStepper: viewModel
        ))
    }

    private func navigateToTabs() -> FlowContributors {
        return .end(forwardToParentFlowWithStep: SharingStep.tabsRequired)
    }

    private func presentErrorAlert(_ content: String) -> FlowContributors {
        let errorAlert = AlertViewController(title: "오류", content: content)
        errorAlert.modalPresentationStyle = .overFullScreen
        rootPresentable.present(errorAlert, animated: false)
        return .none
    }

    private func presentDefaltAlert(_ title: String, _ content: String) -> FlowContributors {
        let errorAlert = AlertViewController(title: title, content: content)
        errorAlert.modalPresentationStyle = .overFullScreen
        rootPresentable.present(errorAlert, animated: false)
        return .none
    }
}
