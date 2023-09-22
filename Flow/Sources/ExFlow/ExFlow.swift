import UIKit
import ExFeature
import RxFlow
import Core
import RxCocoa

class ExFlow: Flow {
    public init() {}

    var root: RxFlow.Presentable {
        return rootPresentable
    }

    private lazy var rootPresentable = UINavigationController()

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
        print("dsfaafasdf")
        let exViewController = ExViewController()
        rootPresentable.pushViewController(exViewController, animated: false)
        return .none
    }
}
