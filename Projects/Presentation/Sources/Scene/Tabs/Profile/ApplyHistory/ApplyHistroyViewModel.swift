import Core
import RxSwift
import RxFlow
import RxCocoa
import Domain

public class ApplyHistroyViewModel: ViewModelType, Stepper {

    public var steps = RxRelay.PublishRelay<RxFlow.Step>()
    public var disposeBag = RxSwift.DisposeBag()
    private let fetchApplyHistoryUseCase: FetchApplyHistoryUseCase
    
    public init(fetchApplyHistoryUseCase: FetchApplyHistoryUseCase) {
        self.fetchApplyHistoryUseCase = fetchApplyHistoryUseCase
    }

    public struct Input {
        let viewWillAppear: Observable<Void>
    }
    public struct Output {
        let ApplyHistoryData: PublishRelay<ApplyHistoryEntity>
    }
    public func transform(input: Input) -> Output {
        let applyHistorydata = PublishRelay<ApplyHistoryEntity>()
        input.viewWillAppear
            .flatMap {
                self.fetchApplyHistoryUseCase.excute()
            }
            .bind(to: applyHistorydata)
            .disposed(by: disposeBag)
        return Output(ApplyHistoryData: applyHistorydata)
    }
}
