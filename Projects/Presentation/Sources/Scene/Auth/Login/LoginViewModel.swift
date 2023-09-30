import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Core

public class LoginViewModel: ViewModelType, Stepper {
    public var steps = PublishRelay<Step>()
    
    public init() {}
    public var disposeBag: DisposeBag = DisposeBag()
    
    public struct Input {
        let signupButtonSignal: Observable<Void>
    }

    public struct Output {
    }

    public func transform(input: Input) -> Output {
        input.signupButtonSignal
            .map { SharingStep.signupRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output()
    }
}
