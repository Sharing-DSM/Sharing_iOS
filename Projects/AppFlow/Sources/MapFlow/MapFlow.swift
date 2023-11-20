import UIKit
import RxFlow
import RxSwift
import RxCocoa
import Presentation
import Core
import Domain

class MapFlow: Flow {

    public init() {}

    private let rootViewController = BaseNavigationController()

    var root: RxFlow.Presentable {
        return rootViewController
    }

    private let container = StepperDI.shared

    func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? SharingStep else { return  .none }
        switch step {
        case .mapRequired:
            return presentMapView()
        case .postWriteRequired:
            return navigateToPostWriteScreen()
        case .popRequired:
            return popWhenSucceedCreatePost()
        case .errorAlertRequired(let content):
            return presentErrorAlert(content)
        case .chatRoomRequired(let roomID):
            return navigateToChatRoom(roomID: roomID)
        default:
            return .none
        }
    }

    private func presentMapView() -> FlowContributors {
        let mapViewModel = container.mapViewModel
        let mapPostView = MapPostViewController(viewModel: mapViewModel)
        let mapView = MapViewController(viewModel: mapViewModel, mapPostVC: mapPostView)

        self.rootViewController.pushViewController(mapView, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: mapView,
            withNextStepper: mapView.viewModel
        ))
    }

    private func navigateToPostDetailScreen() -> FlowContributors {
        let detailViewController = PostDetailViewController(viewModel: container.postDetailViewModel)
        self.rootViewController.pushViewController(detailViewController, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: detailViewController,
            withNextStepper: detailViewController.viewModel
        ))
    }

    private func navigateToPostWriteScreen() -> FlowContributors {
        let addressVC = AddressHelperViewController(viewModel: container.addressViewModel)

        let writeViewController = PostWriteViewController(
            viewModel: container.postWriteViewModel,
            addressHelper: addressVC
        )
        self.rootViewController.pushViewController(writeViewController, animated: true)

        return .one(flowContributor: .contribute(
            withNextPresentable: writeViewController,
            withNextStepper: writeViewController.viewModel
        ))
    }

    private func presentErrorAlert(_ content: String) -> FlowContributors {
        let errorAlert = AlertViewController(title: "오류", content: content)
        errorAlert.modalPresentationStyle = .overFullScreen
        rootViewController.present(errorAlert, animated: false)
        return .none
    }

    private func navigateToChatRoom(roomID: String) -> FlowContributors {
        let chatRoomVC = ChatRoomViewController(viewModel: container.chatRoomViewModel)
        chatRoomVC.roomID = roomID
        self.rootViewController.pushViewController(chatRoomVC, animated: true)

        return .one(flowContributor: .contribute(
            withNextPresentable: chatRoomVC,
            withNextStepper: chatRoomVC.viewModel
        ))
    }

    private func popWhenSucceedCreatePost() -> FlowContributors {
        rootViewController.popViewController(animated: true)
        return .none
    }
}
