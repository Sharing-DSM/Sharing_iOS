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
        case .chatRoomRequired(let roomID):
            return presentChatRoom(roomID: roomID)
        default:
            return .none
        }
    }

    private func presentChatView() -> FlowContributors {
        let chatVC = ChatViewController(viewModel: container.chatViewModel)
        self.rootViewController.pushViewController(chatVC, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: chatVC,
            withNextStepper: chatVC.viewModel
        ))
    }

    private func presentChatRoom(roomID: String) -> FlowContributors {
        let chatRoomVC = ChatRoomViewController(viewModel: container.chatRoomViewModel)
        chatRoomVC.roomID = roomID
        self.rootViewController.pushViewController(chatRoomVC, animated: true)
        return .none
    }
}
