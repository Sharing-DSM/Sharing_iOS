import UIKit
import RxFlow
import Core
import RxCocoa
import Presentation

class TabsFlow: Flow {
    public init() {}

    var root: Presentable {
        return rootPresentable
    }

    private lazy var rootPresentable = UINavigationController(rootViewController: tabBarViewController)

    private let tabBarViewController = {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .white
        return tabBarController
    }()

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

        let homeView = HomeViewController()
        let mapView = MapViewController()
        let profileView = ProfileViewController()
        let chatView = ChatViewController()

        mapView.tabBarItem = UITabBarItem(title: "지도", image: UIImage(systemName: "map"), selectedImage: nil)
        homeView.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "heart"), selectedImage: nil)
        chatView.tabBarItem = UITabBarItem(title: "채팅", image: UIImage(systemName: "message"), selectedImage: nil)
        profileView.tabBarItem = UITabBarItem(title: "MY", image: UIImage(systemName: "book"), selectedImage: nil)
        tabBarViewController.setViewControllers([mapView, homeView, chatView, profileView], animated: false)

        return .none
    }
}
