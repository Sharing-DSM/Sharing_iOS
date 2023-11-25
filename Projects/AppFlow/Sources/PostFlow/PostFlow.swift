import UIKit
import Then
import RxFlow
import Core
import RxCocoa
import Presentation

class PostFlow: Flow {

    var root: Presentable {
        return rootPresentable
    }

    private let rootPresentable: PostDetailViewController
    private let container = StepperDI.shared

    public init() {
        self.rootPresentable = PostDetailViewController(viewModel: container.postDetailViewModel)
    }

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? SharingStep else { return .none }
        switch step {
        case .postDetailRequired(let id):
            return navigateToPostDetailScreen(id: id)
        case .postEditRequired(let id):
            return navigateToPostEditScreen(id: id)
        case .applicantListRequired(let id):
            return navigateToApplicantListScreen(id: id)
        case .chatRoomRequired(let roomID):
            return navigateToChatRoom(roomID: roomID)
        case .errorAlertRequired(let content):
            return presentErrorAlert(content)
        case .alertRequired(let title, let content):
            return presentAlert(title, content)
        case .popRequired:
            return popRequired()
        default:
            return .none
        }
    }

    private func navigateToPostDetailScreen(id: String) -> FlowContributors {
        rootPresentable.id = id
        return .one(flowContributor: .contribute(
            withNextPresentable: rootPresentable,
            withNextStepper: rootPresentable.viewModel
        ))
    }

    private func navigateToPostEditScreen(id: String) -> FlowContributors {
        let addressVC = AddressHelperViewController(viewModel: container.addressViewModel)

        let editViewController = PostEditViewController(
            viewModel: container.postEditViewModel,
            addressHelper: addressVC
        )
        editViewController.postId = id
        self.rootPresentable.navigationController?.pushViewController(editViewController, animated: true)

        return .one(flowContributor: .contribute(
            withNextPresentable: editViewController,
            withNextStepper: editViewController.viewModel
        ))
    }

    private func navigateToApplicantListScreen(id: String) -> FlowContributors {
        let applicantListVC = ApplicantViewController(viewModel: container.applicantViewModel)
        applicantListVC.postID = id

        self.rootPresentable.navigationController?.pushViewController(applicantListVC, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: applicantListVC,
            withNextStepper: applicantListVC.viewModel
        ))
    }

    private func navigateToChatRoom(roomID: String) -> FlowContributors {
        let chatRoomVC = ChatRoomViewController(viewModel: container.chatRoomViewModel)
        chatRoomVC.roomID = roomID

        self.rootPresentable.navigationController?.pushViewController(chatRoomVC, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: chatRoomVC,
            withNextStepper: chatRoomVC.viewModel
        ))
    }

    private func presentErrorAlert(_ content: String) -> FlowContributors {
        let errorAlert = AlertViewController(title: "오류", content: content)
        errorAlert.modalPresentationStyle = .overFullScreen
        errorAlert.modalTransitionStyle = .crossDissolve
        rootPresentable.present(errorAlert, animated: true)
        return .none
    }

    private func presentAlert(_ title: String, _ content: String) -> FlowContributors {
        let alert = AlertViewController(title: title, content: content)
        alert.modalPresentationStyle = .overFullScreen
        alert.modalTransitionStyle = .crossDissolve
        rootPresentable.present(alert, animated: true)
        return .none
    }

    private func popRequired() -> FlowContributors {
        self.rootPresentable.navigationController?.popViewController(animated: true)
        return .none
    }
}
