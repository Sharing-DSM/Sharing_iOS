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
        case .testRequired:
            return testPresent()
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

    private func presentLoginView() -> FlowContributors {
        let authFlow = AuthFlow()
        Flows.use(authFlow, when: .created) { [weak self] root in
            self?.window.rootViewController = root
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: authFlow,
            withNextStepper: OneStepper(withSingleStep: SharingStep.loginRequired)
        ))
    }

    private func testPresent() -> FlowContributors {
        let testFlow = TestFlow()
        Flows.use(testFlow, when: .created) { [weak self] root in
            self?.window.rootViewController = root
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: testFlow,
            withNextStepper: OneStepper(withSingleStep: SharingStep.applicantListRequired(id: ""))
        ))
    }
}
