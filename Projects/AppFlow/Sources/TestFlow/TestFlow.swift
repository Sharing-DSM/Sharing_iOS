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
        default:
            return .none
        }
    }

    private func navigateToHomeScreen() -> FlowContributors {
        let viewModel = container.addressViewModel
        let testVC = AddressHelperViewController(
            viewModel: viewModel
        )
        self.rootViewController.pushViewController(testVC, animated: false)
        return .none
    }
}
