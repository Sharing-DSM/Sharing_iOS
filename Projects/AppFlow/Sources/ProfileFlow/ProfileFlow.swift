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
        case .profileEditRequired:
            return presentProfileEditView()
        case .scheduleRequired:
            return presentScheduleView()
        case .createScheduleRequired:
            return presentCreateScheduleView()
        case .myPostRequired:
            return presentMyPostView()
        case .applyHistoryRequired:
            return presentApplyHistroyView()
        case .successProfileEdit:
            return popViewController()
        case .successCreateSchedule:
            return popViewController()
        case .postDetailRequired(let id):
            return navigateToDetail(id: id)
        case .scheduleEditRequired(let id):
            return navigateScheduleEditView(id: id)
        case .completeScheduleAlertRequired:
            return presentAlert()
        default:
            return .none
        }
    }

    private func presentProfileView() -> FlowContributors {
        let profileView = ProfileViewController(viewModel: container.profileViewModel)

        self.rootViewController.pushViewController(profileView, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: profileView,
            withNextStepper: profileView.viewModel))
    }
    private func presentProfileEditView() -> FlowContributors {
        let profileEditViewController = ProfileEditViewController(viewModel: container.profileEditViewModel)
        self.rootViewController.pushViewController(profileEditViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: profileEditViewController,
            withNextStepper: profileEditViewController.viewModel))
    }
    private func presentScheduleView() -> FlowContributors {
        let scheduleView = ScheduleViewController(viewModel: container.scheduleViewModel)
        self.rootViewController.pushViewController(scheduleView, animated: true)
        
        return .one(flowContributor: .contribute(
            withNextPresentable: scheduleView,
            withNextStepper: scheduleView.viewModel))
    }
    private func presentCreateScheduleView() -> FlowContributors {
        let createScheduleView = CreatScheculeViewController(viewModel: container.createScheduleViewModel)
        self.rootViewController.pushViewController(createScheduleView, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: createScheduleView,
            withNextStepper: createScheduleView.viewModel))
    }
    private func presentMyPostView() -> FlowContributors {
        let myPostView = MyPostViewController(viewModel: container.myPostViewModel)
        self.rootViewController.pushViewController(myPostView, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: myPostView,
            withNextStepper: myPostView.viewModel))
    }
    private func presentApplyHistroyView() -> FlowContributors {
        let applyHistoryVC = ApplyHistoryViewController(viewModel: container.applyHistoryViewModel)
        self.rootViewController.pushViewController(applyHistoryVC, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: applyHistoryVC,
            withNextStepper: applyHistoryVC.viewModel))
    }
    private func popViewController() -> FlowContributors {
        self.rootViewController.popViewController(animated: true)
        return .none
    }
    private func navigateToDetail(id: String) -> FlowContributors {
        let detailViewController = PostDetailViewController(viewModel: container.postDetailViewModel)
        detailViewController.id = id
        self.rootViewController.pushViewController(detailViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: detailViewController,
            withNextStepper: detailViewController.viewModel
        ))
    }
    private func navigateScheduleEditView(id: String) -> FlowContributors {
        let scheduleEditViewController = EditScheduleViewController(viewModel: container.editScheduleViewModel)
        scheduleEditViewController.cellId = id
        self.rootViewController.pushViewController(scheduleEditViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: scheduleEditViewController,
            withNextStepper: scheduleEditViewController.viewModel
        ))
    }
    private func presentAlert() -> FlowContributors {
        let alert = UIAlertController(title: "일정이 완료되었습니다", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: { _ in })
        alert.addAction(okAction)
        self.rootViewController.present(alert, animated: true)
        return .none
    }
}
