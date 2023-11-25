import UIKit
import Then
import RxFlow
import Core
import RxCocoa
import Presentation

class TabsFlow: Flow {
    public init() {}

    var root: Presentable {
        return rootPresentable
    }

    private let tabBarManager = TabBarManager.shared
    private lazy var rootPresentable = TabBarManager.shared.manageTabBarController().then {
        $0.tabBar.backgroundColor = .white
        $0.tabBar.tintColor = .blue400
        $0.tabBar.unselectedItemTintColor = .black600
        $0.tabBar.backgroundImage = UIImage()
        $0.tabBar.shadowImage = UIImage()
        let tabbarView = UIView().then {
            $0.setShadow()
            $0.backgroundColor = .black50
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        $0.tabBar.addSubview(tabbarView)
        tabbarView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }

    private let container = StepperDI.shared

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? SharingStep else { return .none }
        switch step {
        case .tabsRequired:
            return navigateToTabsView()
        default:
            return .none
        }
    }

    private func navigateToTabsView() -> FlowContributors {
        let mapFlow = MapFlow()
        let homeFlow = HomeFlow()
        let chatFlow = ChatFlow()
        let profileFlow = ProfileFlow()
        
        Flows.use(
            mapFlow,
            homeFlow,
            chatFlow,
            profileFlow,
            when: .created
        ) { [weak self] root1, root2, root3, root4 in
            let tabItem1 = UITabBarItem(
                title: "지도",
                image: .mapIcon,
                selectedImage: .mapIcon.withTintColor(.blue400!, renderingMode: .alwaysOriginal)
            ).then {
                $0.setTitleTextAttributes([.font: UIFont.bodyB3Medium], for: .normal)
            }
            let tabItem2 = UITabBarItem(
                title: "홈",
                image: .homeIcon,
                selectedImage: .homeIcon.withTintColor(.blue400!, renderingMode: .alwaysOriginal)
            ).then {
                $0.setTitleTextAttributes([.font: UIFont.bodyB3Medium], for: .normal)
            }
            let tabItem3 = UITabBarItem(
                title: "채팅",
                image: .chatIcon,
                selectedImage: .chatIcon.withTintColor(.blue400!, renderingMode: .alwaysOriginal)
            ).then {
                $0.setTitleTextAttributes([.font: UIFont.bodyB3Medium], for: .normal)
            }
            let tabItem4 = UITabBarItem(
                title: "MY",
                image: .profileIcon,
                selectedImage: .profileIcon.withTintColor(.blue400!, renderingMode: .alwaysOriginal)
            ).then {
                $0.setTitleTextAttributes([.font: UIFont.bodyB3Medium], for: .normal)
            }
            root1.tabBarItem = tabItem1
            root2.tabBarItem = tabItem2
            root3.tabBarItem = tabItem3
            root4.tabBarItem = tabItem4
            
            self?.rootPresentable.setViewControllers([root1, root2, root3, root4], animated: false)
        }

        return .multiple(flowContributors: [
            .contribute(
                withNextPresentable: mapFlow,
                withNextStepper: OneStepper(withSingleStep: SharingStep.mapRequired)
            ),
            .contribute(
                withNextPresentable: homeFlow,
                withNextStepper: OneStepper(withSingleStep: SharingStep.homeRequired)
            ),
            .contribute(
                withNextPresentable: chatFlow,
                withNextStepper: OneStepper(withSingleStep: SharingStep.chatRequired)
            ),
            .contribute(
                withNextPresentable: profileFlow,
                withNextStepper: OneStepper(withSingleStep: SharingStep.profileRequired)
            ),
        ])
    }
}
