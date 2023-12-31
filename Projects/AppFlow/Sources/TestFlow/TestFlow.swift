import UIKit
import RxFlow
import RxSwift
import RxCocoa
import Presentation
import Core
import Data

class TestFlow: Flow {

    private let rootViewController = BaseNavigationController()

    private let container = StepperDI.shared

    var root: RxFlow.Presentable {
        return rootViewController
    }

    func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? SharingStep else { return  .none }
        switch step {
        case .homeRequired:
            return navigateToHomeScreen()
        case .createScheduleRequired:
            return navigateToCreateScheduleScreen()
        case .scheduleRequired:
            return navigateToScheduleScreen()
        case .applicantListRequired:
            return navigateToApplicantList(id: "")
        default:
            return .none
        }
    }

    private func navigateToApplicantList(id: String) -> FlowContributors {
        let applicantView = ApplicantViewController(viewModel: container.applicantViewModel)
        self.rootViewController.pushViewController(applicantView, animated: false)
        return .none
    }

    private func navigateToHomeScreen() -> FlowContributors {
        let testVC = HomeViewController(viewModel: container.homeViewModel)
        self.rootViewController.pushViewController(testVC, animated: false)
        return .none
    }
    private func navigateToCreateScheduleScreen() -> FlowContributors {
        let homeViewController = CreatScheculeViewController(viewModel: container.createScheduleViewModel)
        self.rootViewController.pushViewController(homeViewController, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: homeViewController,
            withNextStepper:  OneStepper(withSingleStep: SharingStep.createScheduleRequired)
        ))
    }
    private func navigateToScheduleScreen() -> FlowContributors {
        let homeViewController = ScheduleViewController(viewModel: container.scheduleViewModel)
        self.rootViewController.pushViewController(homeViewController, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: homeViewController,
            withNextStepper:  OneStepper(withSingleStep: SharingStep.scheduleRequired)
        ))
    }

    private func navigateToChatRoom() -> FlowContributors {
        let chatRoomViewController = ChatRoomViewController(viewModel: container.chatRoomViewModel)
        self.rootViewController.pushViewController(chatRoomViewController, animated: false)
        return .none
    }
}
