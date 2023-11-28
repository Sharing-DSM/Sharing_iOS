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
        case .postSearchRequired:
            return navigateToPostSearchScreen()
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
        let postFlow = PostFlow()
        
        Flows.use(postFlow, when: .created) { [weak self] root in
            self?.rootViewController.pushViewController(root, animated: true)
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: postFlow,
            withNextStepper: OneStepper(withSingleStep: SharingStep.postDetailRequired(id: id))
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

    private func navigateToPostSearchScreen() -> FlowContributors {
        let searchVC = SearchViewController(viewModel: container.searchViewModel)
        self.rootViewController.pushViewController(searchVC, animated: true)
        
        return .one(flowContributor: .contribute(
            withNextPresentable: searchVC,
            withNextStepper: searchVC.viewModel
        ))
    }
    
    
    private func popRequired() -> FlowContributors {
        self.rootViewController.popViewController(animated: true)
        return .none
    }
}
