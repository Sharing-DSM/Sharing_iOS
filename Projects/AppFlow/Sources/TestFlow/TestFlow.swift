import UIKit
import RxFlow
import RxSwift
import RxCocoa
import Presentation
import Core

class TestFlow: Flow {

    private let rootViewController = UINavigationController()

    var root: RxFlow.Presentable {
        return rootViewController
    }

    private let container = StepperDI.shared

    func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? SharingStep else { return  .none }
        switch step {
        case .homeRequired:
            return navigateToHomeScreen()
        case .profileEditRequired:
            return navigateToProfileEditScreen()
        case .createScheduleRequired:
            return navigateToCreateScheduleScreen()
        case .scheduleRequired:
            return navigateToScheduleScreen()
        default:
            return .none
        }
    }

    private func navigateToHomeScreen() -> FlowContributors {
        let homeViewController = PostWriteViewController()
        self.rootViewController.pushViewController(homeViewController, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: homeViewController,
            withNextStepper:  OneStepper(withSingleStep: SharingStep.homeRequired)
        ))
    }
    private func navigateToProfileEditScreen() -> FlowContributors {
        let homeViewController = ProfileEditViewController(viewModel: container.profileEditViewModel)
        self.rootViewController.pushViewController(homeViewController, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: homeViewController,
            withNextStepper:  OneStepper(withSingleStep: SharingStep.profileEditRequired)
        ))
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
        let homeViewController = ScheduleViewController()
        self.rootViewController.pushViewController(homeViewController, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: homeViewController,
            withNextStepper:  OneStepper(withSingleStep: SharingStep.scheduleRequired)
        ))
    }
}
