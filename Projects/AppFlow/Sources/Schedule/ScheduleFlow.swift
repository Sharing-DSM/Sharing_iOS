import UIKit
import Then
import RxFlow
import Core
import RxCocoa
import Presentation

class ScheduleFlow: Flow {

    var root: Presentable {
        return rootPresentable
    }

    private let rootPresentable: ScheduleViewController
    private let container = StepperDI.shared

    public init() {
        self.rootPresentable = ScheduleViewController(viewModel: container.scheduleViewModel)
    }

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? SharingStep else { return .none }
        switch step {
        case .scheduleRequired:
            return navigateToScheduleScreen()
        case .scheduleEditRequired(let id):
            return navigateScheduleEditView(id: id)
        case .createScheduleRequired:
            return presentCreateScheduleView()
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

    private func navigateToScheduleScreen() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: rootPresentable,
            withNextStepper: rootPresentable.viewModel
        ))
    }

    private func navigateScheduleEditView(id: String) -> FlowContributors {
        let scheduleEditViewController = EditScheduleViewController(viewModel: container.editScheduleViewModel)
        scheduleEditViewController.cellId = id
        self.rootPresentable.navigationController?.pushViewController(scheduleEditViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: scheduleEditViewController,
            withNextStepper: scheduleEditViewController.viewModel
        ))
    }

    private func presentCreateScheduleView() -> FlowContributors {
        let createScheduleView = CreatScheculeViewController(viewModel: container.createScheduleViewModel)
        self.rootPresentable.navigationController?.pushViewController(createScheduleView, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: createScheduleView,
            withNextStepper: createScheduleView.viewModel))
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
