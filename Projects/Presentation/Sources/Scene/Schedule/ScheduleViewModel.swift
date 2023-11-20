import Foundation
import Domain
import Core
import RxSwift
import RxFlow
import RxCocoa

public class ScheduleViewModel: ViewModelType, Stepper {
    public var steps = RxRelay.PublishRelay<RxFlow.Step>()
    
    public var disposeBag = RxSwift.DisposeBag()

    private let fetchCompleteScheduleUseCase: FetchCompletScheduleUseCase
    private let fetchUnCompleteScheduleUseCase: FetchUnCompleteScheduleUseCase
    private let completeScheduleUseCase: CompleteScheduleUseCase
    private let deleteScheduleUseCase: DeleteScheduleUseCase

    public init(
        fetchCompleteScheduleUseCase: FetchCompletScheduleUseCase,
        fetchUnCompleteScheduleUseCase: FetchUnCompleteScheduleUseCase,
        completeScheduleUseCase: CompleteScheduleUseCase,
        deleteScheduleUseCase: DeleteScheduleUseCase
    ) {
        self.fetchCompleteScheduleUseCase = fetchCompleteScheduleUseCase
        self.fetchUnCompleteScheduleUseCase = fetchUnCompleteScheduleUseCase
        self.completeScheduleUseCase = completeScheduleUseCase
        self.deleteScheduleUseCase = deleteScheduleUseCase
    }

    public struct Input {
        let viewWillAppear: Observable<Void>
        let writeButtonDidTap: Observable<Void>
        let deleteSchedule: Observable<String>
        let completeScheduleRelay: Observable<String>
        let editRequired: Observable<String>
    }
    public struct Output {
        let completeScheduleList: PublishRelay<[CompleteScheduleEntity]>
        let unCompleteScheduleList: PublishRelay<[UncompleteScheduleEntity]>
    }

    public func transform(input: Input) -> Output {
        let completeSchedules = PublishRelay<[CompleteScheduleEntity]>()
        let unCompleteSchedules = PublishRelay<[UncompleteScheduleEntity]>()
        input.viewWillAppear
            .flatMap {
                self.fetchUnCompleteScheduleUseCase.excute()
            }
            .bind(to: unCompleteSchedules)
            .disposed(by: disposeBag)
        input.viewWillAppear
            .flatMap {
                self.fetchCompleteScheduleUseCase.excute()
            }
            .bind(to: completeSchedules)
            .disposed(by: disposeBag)
        input.deleteSchedule
            .flatMap { id in
                self.deleteScheduleUseCase.excute(id: id)
                    .andThen(Single.just(SharingStep.tabsRequired))
            }
            .bind(to: steps)
            .disposed(by: disposeBag)
        input.completeScheduleRelay
            .flatMap { id in
                self.completeScheduleUseCase.excute(id: id)
                    .catch {
                        print($0.localizedDescription)
                        return .never()
                    }
                    .andThen(Single.just(SharingStep.completeScheduleAlertRequired))
            }
            .bind(to: steps)
            .disposed(by: disposeBag)
        input.writeButtonDidTap
            .map { SharingStep.createScheduleRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)
        input.editRequired
            .map { SharingStep.scheduleEditRequired(id: $0) }
            .bind(to: steps)
            .disposed(by: disposeBag)
        return Output(completeScheduleList: completeSchedules, unCompleteScheduleList: unCompleteSchedules)
    }
}
