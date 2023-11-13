import UIKit
import Presentation
import RxFlow
import Core

class AuthFlow: Flow {
    public init() {}

    var root: Presentable {
        return rootPresentable
    }

    private lazy var rootPresentable = BaseNavigationController()
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
        case .succeedSignupRequired:
            return presentSucceedSignup()
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

    private func presentSucceedSignup() -> FlowContributors {
        let alert = AlertViewController(
            title: "회원가입 성공",
            content: "같은 아이디와 비밀번호로 로그인을 시도해주세요."
        )
        alert.modalPresentationStyle = .overFullScreen
        rootPresentable.present(alert, animated: false)
        rootPresentable.popViewController(animated: true)
        return .none
    }
}
