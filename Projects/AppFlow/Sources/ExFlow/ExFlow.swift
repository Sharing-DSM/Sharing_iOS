import UIKit
import Presentation
import RxFlow
import Core
import RxCocoa

class ExFlow: Flow {
    public init() {}

    var root: Presentable {
        return rootPresentable
    }

    private lazy var rootPresentable = UINavigationController()

    func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? SharingStep else { return .none }
        switch step {
        case .exRequired:
            return navigateToExView()
        default:
            return .none
        }
    }

    private func navigateToExView() -> FlowContributors {
        let exViewController = ExViewController()
        rootPresentable.pushViewController(exViewController, animated: false)
        return .none
    }
}
