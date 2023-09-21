import UIKit
import RxFlow
import RxCocoa

class TabsFlow: Flow {
    var root: RxFlow.Presentable {
        return rootPresentable
    }

    private lazy var rootPresentable = UINavigationController()

    func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? SharingStep else { return .none }
        switch step {
        case .exRequired:
            return navigateToTabsView()
        default:
            return .none
        }
    }

    private func navigateToTabsView() -> FlowContributors {
        let exFlow = ExFlow()
        Flows.use(exFlow, when: .created) { [weak self] root in
            let tabbarItem = UITabBarItem(title: "예시", image: UIImage(systemName: "heart"), selectedImage: nil)
            root.tabBarItem = tabbarItem
            self?.rootPresentable.setViewControllers([root], animated: false)
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: exFlow,
            withNextStepper: OneStepper(withSingleStep: SharingStep.exRequired)
        ))
    }
}

