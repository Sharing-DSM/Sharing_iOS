import UIKit
import RxFlow
import Core

public class AppFlow: Flow {
    private var window: UIWindow

    public var root: RxFlow.Presentable {
        return window
    }

    public init(window: UIWindow) {
        self.window = window
    }

    public func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? SharingStep else { return .none }
        switch step {
        case .tabsRequired:
            return presentTabsView()
        case .loginRequired:
            return presentLoginView()
        default:
            return .none
        }
    }

    private func presentTabsView() -> FlowContributors {
        let tabsFlow = TabsFlow()
        Flows.use(tabsFlow, when: .created) { [weak self] root in
            self?.window.rootViewController = root
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: tabsFlow,
            withNextStepper: OneStepper(withSingleStep: SharingStep.tabsRequired)
        ))
    }

    // TODO: 온보딩 뷰 연결
    private func presentLoginView() -> FlowContributors {
        let loginFlow = LoginFlow()
        Flows.use(loginFlow, when: .created) { [weak self] root in
            self?.window.rootViewController = root
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: loginFlow,
            withNextStepper: OneStepper(withSingleStep: SharingStep.loginRequired)
        ))
    }
}
