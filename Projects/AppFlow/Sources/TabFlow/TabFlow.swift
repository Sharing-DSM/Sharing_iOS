import UIKit
import RxFlow
import Core
import RxCocoa

class TabsFlow: Flow {
    public init() {}

    var root: Presentable {
        return rootPresentable
    }

    private lazy var rootPresentable =  {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .white
        return tabBarController
    }()

    // TODO: 텝바 로직 만들기
    func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? SharingStep else { return .none }
        switch step {
        case .tabsRequired:
            return .none
        default:
            return .none
        }
    }

    private func navigateToTabsView() -> FlowContributors {
        let exFlow = SignupFlow()
        Flows.use(exFlow, when: .created) { [weak self] root in
            let tabbarItem = UITabBarItem(title: "예시", image: UIImage(systemName: "heart"), selectedImage: nil)
            root.tabBarItem = tabbarItem
            self?.rootPresentable.setViewControllers([root], animated: false)
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: exFlow,
            withNextStepper: OneStepper(withSingleStep: SharingStep.signupRequired)
        ))
    }
}

