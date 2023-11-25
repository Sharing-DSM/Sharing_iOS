import UIKit
import Then
import RxFlow
import Core
import RxCocoa
import Presentation

class ApplyHistroyFlow: Flow {

    var root: Presentable {
        return rootPresentable
    }

    private let rootPresentable: ApplyHistoryViewController
    private let container = StepperDI.shared

    public init() {
        self.rootPresentable = ApplyHistoryViewController(viewModel: container.applyHistoryViewModel)
    }

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? SharingStep else { return .none }
        switch step {
        case .applyHistoryRequired:
            return navigateToApplyHistoryRequiredScreen()
        case .postDetailRequired(let id):
            return navigateToPostDetailScreen(id: id)
        case .errorAlertRequired(let content):
            return presentErrorAlert(content)
        case .alertRequired(let title, let content):
            return presentAlert(title, content)
        case .popRequired:
            return popRequired()
        default:
            return .none
        }
    }

    private func navigateToApplyHistoryRequiredScreen() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: rootPresentable,
            withNextStepper: rootPresentable.viewModel
        ))
    }

    private func navigateToPostDetailScreen(id: String) -> FlowContributors {
        let postFlow = PostFlow()
        
        Flows.use(postFlow, when: .created) { [weak self] root in
            self?.rootPresentable.navigationController?.pushViewController(root, animated: true)
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: postFlow,
            withNextStepper: OneStepper(withSingleStep: SharingStep.postDetailRequired(id: id))
        ))
    }

    private func presentErrorAlert(_ content: String) -> FlowContributors {
        let errorAlert = AlertViewController(title: "오류", content: content)
        errorAlert.modalPresentationStyle = .overFullScreen
        errorAlert.modalTransitionStyle = .crossDissolve
        rootPresentable.present(errorAlert, animated: true)
        return .none
    }

    private func presentAlert(_ title: String, _ content: String) -> FlowContributors {
        let alert = AlertViewController(title: title, content: content)
        alert.modalPresentationStyle = .overFullScreen
        alert.modalTransitionStyle = .crossDissolve
        rootPresentable.present(alert, animated: true)
        return .none
    }

    private func popRequired() -> FlowContributors {
        self.rootPresentable.navigationController?.popViewController(animated: true)
        return .none
    }
}
