import UIKit
import RxFlow
import RxSwift
import RxCocoa
import Presentation
import Core

class HomeFlow: Flow{

    private let rootViewController = UINavigationController()

    var root: RxFlow.Presentable {
        return rootViewController
    }

    func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? SharingStep else { return  .none }
        switch step {
        case .homeRequired:
            return navigateToHomeScreen()
        case .postDetailsRequired:
            return navigateToPostDetailScreen()
        case .postWriteRequired:
            return navigateToPostWriteScreen()
        default:
            return .none
            
        }
    }

    private func navigateToHomeScreen() -> FlowContributors {
        let homeViewController = HomeViewController()
        self.rootViewController.pushViewController(homeViewController, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: homeViewController,
            withNextStepper:  OneStepper(withSingleStep: SharingStep.homeRequired)
        ))
    }

    private func navigateToPostDetailScreen() -> FlowContributors {
        let detailViewController = DetailViewController()
        self.rootViewController.pushViewController(detailViewController, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: detailViewController,
            withNextStepper: OneStepper(withSingleStep: SharingStep.postDetailsRequired))
        )
    }
    private func navigateToPostWriteScreen() -> FlowContributors {
        let writeViewController = WriteViewController()
        self.rootViewController.pushViewController(writeViewController, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: writeViewController,
            withNextStepper: OneStepper(withSingleStep: SharingStep.homeRequired))
        )
    }
}
