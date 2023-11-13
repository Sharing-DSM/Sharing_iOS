import UIKit
import RxFlow
import RxSwift
import RxCocoa
import Presentation
import Core

class ChatFlow: Flow {

    public init() {}

    private let rootViewController = BaseNavigationController()

    var root: RxFlow.Presentable {
        return rootViewController
    }

    private let container = StepperDI.shared

    func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? SharingStep else { return  .none }
        switch step {
        case .chatRequired:
            return presentChatView()
        default:
            return .none
        }
    }

    private func presentChatView() -> FlowContributors {
        let chatView = ChatViewController()

        self.rootViewController.pushViewController(chatView, animated: false)
        return .none
    }
}
