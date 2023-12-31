import Foundation
import RxFlow
import RxSwift
import RxCocoa
import Domain
import Core

public class CreateSheduleViewModel: ViewModelType, Stepper {
    
    public var steps = PublishRelay<RxFlow.Step>()
    
    public var disposeBag = DisposeBag()

    let postScheduleUseCase: PostScheduleUseCase

    public init(postScheduleUseCase: PostScheduleUseCase) {
        self.postScheduleUseCase = postScheduleUseCase
    }
    

    public struct Input {
        let titleText: Observable<String>
        let dateText: Observable<Date>
        let completeButtonDidTap: Observable<Void>
    }
    public struct Output {
    }

    public func transform(input: Input) -> Output {
        let info = Observable.combineLatest(input.titleText, input.dateText.map { $0.toString("yyyy-MM-dd") })

        input.completeButtonDidTap
            .withLatestFrom(info)
            .flatMap { title, date in
                self.postScheduleUseCase.excute(title: title, date: date)
                    .andThen(Single.just(SharingStep.popRequired))
            }
            .bind(to: steps)
            .disposed(by: disposeBag)
        return Output()
    }
}
