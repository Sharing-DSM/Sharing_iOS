import Core
import RxFlow
import RxCocoa
import RxSwift
import Domain

public class SetAreaOfIntrestViewModel: ViewModelType, Stepper {
    
    public var steps = RxRelay.PublishRelay<RxFlow.Step>()
    public var disposeBag: RxSwift.DisposeBag = DisposeBag()
    private let setAreaOfInterestUseCase: SetAreaOfInterestUseCase

    public init(setAreaOfInterestUseCase: SetAreaOfInterestUseCase) {
        self.setAreaOfInterestUseCase = setAreaOfInterestUseCase
    }

    public struct Input {
        let addressData: Observable<AddressEntityElement?>
        let completeButtonDidTap: Observable<Void>
    }
    public struct Output {}

    public func transform(input: Input) -> Output {
        input.completeButtonDidTap.withLatestFrom(input.addressData)
            .flatMap { address -> Single<SharingStep> in
                guard let address = address else { return .just(SharingStep.errorAlertRequired(content: "올바르지 않은 타입")) }
                return self.setAreaOfInterestUseCase.excute(addressName: address.addressName)
                    .andThen(.just(SharingStep.popRequired))
                    .catch {
                        print($0.localizedDescription)
                        return .just(SharingStep.errorAlertRequired(content: $0.localizedDescription))
                    }
            }
            .subscribe(onNext: { [weak self] step in
                self?.steps.accept(step)
            })
            .disposed(by: disposeBag)
        return Output()
    }
}
