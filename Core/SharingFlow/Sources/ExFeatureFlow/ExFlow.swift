import UIKit
import RxFlow
import RxCocoa

class ExFlow: Flow {
    var root: RxFlow.Presentable {
        return rootPresentable
    }

    private lazy var rootPresentable = UITabBarController()

    func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? SharingStep else { return .none }
        switch step {
        case .tabsRequired:
            return navigateToExView()
        default:
            return .none
        }
    }

    private func navigateToExView() -> FlowContributors {
        return .none
    }
}

