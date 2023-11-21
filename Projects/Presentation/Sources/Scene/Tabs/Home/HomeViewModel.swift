import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Core
import Domain

public class HomeViewModel: ViewModelType, Stepper {

    public var steps = PublishRelay<Step>()
    public var disposeBag = DisposeBag()

    private let fetchPopularityPostUseCase: FetchPopularityPostUseCase
    private let fetchEmergencyPostUseCase: FetchEmergencyPostUseCase

    public init(
        fetchPopularityPostUseCase: FetchPopularityPostUseCase,
        fetchEmergencyPostUseCase: FetchEmergencyPostUseCase
    ) {
        self.fetchPopularityPostUseCase = fetchPopularityPostUseCase
        self.fetchEmergencyPostUseCase = fetchEmergencyPostUseCase
    }

    let popularityPostData = PublishRelay<PopularityPostEntity>()
    let emergencyPostData = PublishRelay<CommonPostEntity>()

    public struct Input {
        let viewWillApper: Observable<Void>
        let showDetailPost: Observable<String>
        let writePostButtonDidClick: Observable<Void>
    }

    public struct Output {
        let popularityPostData: Signal<PopularityPostEntity>
        let emergencyPostData: Signal<CommonPostEntity>
    }

    public func transform(input: Input) -> Output {
        input.viewWillApper
            .flatMap {
                self.fetchPopularityPostUseCase.excute()
                    .catch {
                        print($0.localizedDescription)
                        return .never()
                    }
            }
            .bind(to: popularityPostData)
            .disposed(by: disposeBag)

        input.viewWillApper
            .flatMap {
                self.fetchEmergencyPostUseCase.excute()
                    .catch {
                        print($0.localizedDescription)
                        return .never()
                    }
            }
            .bind(to: emergencyPostData)
            .disposed(by: disposeBag)
        

        input.showDetailPost
            .map { SharingStep.postDetailRequired(id: $0) }
            .bind(to: steps)
            .disposed(by: disposeBag)
        
        input.writePostButtonDidClick
            .map { SharingStep.postWriteRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output(
            popularityPostData: popularityPostData.asSignal(),
            emergencyPostData: emergencyPostData.asSignal()
        )
    }
}
