import UIKit
import RxFlow
import RxSwift
import RxCocoa
import Presentation
import Core

class HomeFlow: Flow {

    private let rootViewController = BaseNavigationController()

    var root: RxFlow.Presentable {
        return rootViewController
    }

    private let container = StepperDI.shared

    func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? SharingStep else { return  .none }
        switch step {
        case .homeRequired:
            return navigateToHomeScreen()
        case .postDetailRequired(let id):
            return navigateToPostDetailScreen(id: id)
        case .postWriteRequired:
            return navigateToPostWriteScreen()
        case .postEditRequired(let id):
            return navigateToPostEditScreen(id: id)
        case .popRequired:
            return popRequired()
        default:
            return .none
        }
    }

    private func navigateToHomeScreen() -> FlowContributors {
        let homeViewController = HomeViewController(viewModel: container.homeViewModel)
        self.rootViewController.pushViewController(homeViewController, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: homeViewController,
            withNextStepper: homeViewController.viewModel
        ))
    }

    private func navigateToPostDetailScreen(id: String) -> FlowContributors {
        let detailViewController = PostDetailViewController(viewModel: container.postDetailViewModel)
        detailViewController.id = id
        self.rootViewController.pushViewController(detailViewController, animated: true)
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

    private func navigateToPostEditScreen(id: String) -> FlowContributors {
        let addressVC = AddressHelperViewController(viewModel: container.addressViewModel)

        let editViewController = PostEditViewController(
            viewModel: container.postEditViewModel,
            addressHelper: addressVC
        )
        editViewController.postId = id
        self.rootViewController.pushViewController(editViewController, animated: true)

        return .one(flowContributor: .contribute(
            withNextPresentable: editViewController,
            withNextStepper: editViewController.viewModel
        ))
    }

    private func popRequired() -> FlowContributors {
        self.rootViewController.popViewController(animated: true)
        return .none
    }

//    private func navigateToPostWriteScreen() -> FlowContributors {
//        let writeViewController = PostWriteViewController(
//            viewModel: PostWriteViewModel(),
//            addressHelper:
//        )
//        self.rootViewController.pushViewController(writeViewController, animated: false)
//        return .one(flowContributor: .contribute(
//            withNextPresentable: writeViewController,
//            withNextStepper: OneStepper(withSingleStep: SharingStep.homeRequired))
//        )
//    }
}
