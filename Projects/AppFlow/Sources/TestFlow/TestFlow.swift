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

    func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? SharingStep else { return  .none }
        switch step {
        case .homeRequired:
            return navigateToHomeScreen()
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
}
