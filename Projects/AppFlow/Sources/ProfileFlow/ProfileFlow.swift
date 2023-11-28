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
        case .setAreaOfInterestRequired:
            return presentSetAreaOfInterestView()
        case .scheduleRequired:
            return presentScheduleView()
        case .myPostRequired:
            return presentMyPostView()
        case .applyHistoryRequired:
            return presentApplyHistroyView()
        case .guideLineRequired:
            return presentGuideLineView()
        case .loginRequired:
            return logout()
        case .popRequired:
            return popViewController()
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

    private func presentSetAreaOfInterestView() -> FlowContributors {
        let addressVC = AddressHelperViewController(viewModel: container.addressViewModel)
        let setAreaOfInterestVC = SetAreaOfInterestViewController(
            viewModel: container.setAreaOfInterestViewModel,
            addressHelper: addressVC
        )
        self.rootViewController.pushViewController(setAreaOfInterestVC, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: setAreaOfInterestVC,
            withNextStepper: setAreaOfInterestVC.viewModel))
    }

    private func presentScheduleView() -> FlowContributors {
        let scheduleFlow = ScheduleFlow()
        Flows.use(scheduleFlow, when: .created) { [weak self] root in
            self?.rootViewController.pushViewController(root, animated: true)
        }
        
        return .one(flowContributor: .contribute(
            withNextPresentable: scheduleFlow,
            withNextStepper: OneStepper(withSingleStep: SharingStep.scheduleRequired)
        ))
    }

    private func presentMyPostView() -> FlowContributors {
        let myPostFlow = MyPostFlow()
        Flows.use(myPostFlow, when: .created) { [weak self] root in
            self?.rootViewController.pushViewController(root, animated: true)
        }
        
        return .one(flowContributor: .contribute(
            withNextPresentable: myPostFlow,
            withNextStepper: OneStepper(withSingleStep: SharingStep.myPostRequired)
        ))
    }

    private func presentApplyHistroyView() -> FlowContributors {
        let applyHistoryFlow = ApplyHistroyFlow()
        Flows.use(applyHistoryFlow, when: .created) { [weak self] root in
            self?.rootViewController.pushViewController(root, animated: true)
        }
        
        return .one(flowContributor: .contribute(
            withNextPresentable: applyHistoryFlow,
            withNextStepper: OneStepper(withSingleStep: SharingStep.applyHistoryRequired)
        ))
    }

    private func presentGuideLineView() -> FlowContributors {
        let guideLineVC = GuideLineViewController()
        self.rootViewController.pushViewController(guideLineVC, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: guideLineVC,
            withNextStepper: OneStepper(withSingleStep: SharingStep.guideLineRequired)))
    }

    private func logout() -> FlowContributors {
        return .end(forwardToParentFlowWithStep: SharingStep.loginRequired)
    }

    private func popViewController() -> FlowContributors {
        self.rootViewController.popViewController(animated: true)
        return .none
    }
}
