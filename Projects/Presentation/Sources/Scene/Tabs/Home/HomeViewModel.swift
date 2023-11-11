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

    public init(fetchPopularityPostUseCase: FetchPopularityPostUseCase) {
        self.fetchPopularityPostUseCase = fetchPopularityPostUseCase
    }

    let popularityPostData = PublishRelay<PopularityPostEntity>()

    public struct Input {
        let viewWillApper: Observable<Void>
        let showDetailPost: Observable<String>
        let writePostButtonDidClick: Observable<Void>
    }

    public struct Output {
        let popularityPostData: Signal<PopularityPostEntity>
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

        input.showDetailPost
            .map { SharingStep.postDetailRequired(id: $0) }
            .bind(to: steps)
            .disposed(by: disposeBag)
        
        input.writePostButtonDidClick
            .map { SharingStep.postWriteRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output(
            popularityPostData: popularityPostData.asSignal()
        )
    }
}
