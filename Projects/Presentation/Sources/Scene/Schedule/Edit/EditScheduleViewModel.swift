import Foundation
import Core
import RxSwift
import RxFlow
import RxCocoa
import Domain

public class EditScheduleViewModel: ViewModelType, Stepper {

    public var steps = RxRelay.PublishRelay<RxFlow.Step>()
    public var disposeBag = DisposeBag()
    private let editScheduleUseCase: PatchScheduleUseCase

    public init(editScheduleUseCase: PatchScheduleUseCase) {
        self.editScheduleUseCase = editScheduleUseCase
    }

    public struct Input {
        let cellId: String
        let scheduleEditButtonDidTap: Observable<Void>
        let titleText: Observable<String>
        let dateText: Observable<Date>
    }
    public struct Output {}

    public func transform(input: Input) -> Output {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let info = Observable.combineLatest(input.titleText, input.dateText.map { dateFormatter.string(from: $0) })
        input.scheduleEditButtonDidTap
            .withLatestFrom(info)
            .flatMap { title, date in
                self.editScheduleUseCase.excute(id: input.cellId, title: title, date: date)
                    .andThen(Single.just(SharingStep.successProfileEdit))
            }
            .bind(to: steps)
            .disposed(by: disposeBag)
        return Output()
    }
}
