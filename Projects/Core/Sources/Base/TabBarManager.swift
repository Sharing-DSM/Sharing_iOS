import UIKit
import SnapKit
import Then

public class TabBarManager {

    public static let shared = TabBarManager()
    private init() {}

    private var tabBarController = UITabBarController()

    public func registerTabBarToManage(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    public func manageTabBarController() -> UITabBarController {
        return tabBarController
    }

    public func selectIndex(index: Int) {
        self.tabBarController.selectedIndex = index
    }
}
