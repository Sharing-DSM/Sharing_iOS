import RxFlow
import RxCocoa
import Core

public class AppStepper: Stepper {
    public var steps = PublishRelay<Step>()

    public init() { }

    // TODO: 분기처리
    /// - 자동 로그인 분기처리 부분임
    /// - 나중에 분기처리 하기
    public func readyToEmitSteps() {
        steps.accept(SharingStep.tabsRequired)
    }
} 
