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

    private lazy var rootPresentable = UINavigationController(rootViewController: tabBarViewController).then {
        $0.navigationBar.isHidden = true
    }

    private let tabBarViewController = {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .white
        return tabBarController
    }()

    private let container = StepperDI.shared

    // TODO: 텝바 로직 만들기
    func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? SharingStep else { return .none }
        switch step {
        case .tabsRequired:
            return navigateToTabsView()
        default:
            return .none
        }
    }

    private func navigateToTabsView() -> FlowContributors {
        let mapViewModel = container.mapViewModel
        let userProfileViewModel = container.profileViewModel
        
        let mapPostView = MapPostViewController(viewModel: mapViewModel) // MapViewModel inject
        let mapView = MapViewController(viewModel: mapViewModel, mapPostVC: mapPostView) // MapViewModel inject

        let homeView = HomeViewController()
        let profileView = ProfileViewController(viewModel: userProfileViewModel)
        let chatView = ChatViewController()

        mapView.tabBarItem = UITabBarItem(title: "지도", image: UIImage(systemName: "map"), selectedImage: nil)
        homeView.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: nil)
        chatView.tabBarItem = UITabBarItem(title: "채팅", image: UIImage(systemName: "message"), selectedImage: nil)
        profileView.tabBarItem = UITabBarItem(title: "MY", image: UIImage(systemName: "person.crop.circle"), selectedImage: nil)
        tabBarViewController.setViewControllers([mapView, homeView, chatView, profileView], animated: false)

        return .none
    }
}
