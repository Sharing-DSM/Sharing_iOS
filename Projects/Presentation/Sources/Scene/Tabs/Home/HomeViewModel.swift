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
    private let fetchAreaOfInterestUseCase: FetchAreaOfInteresPostUseCase

    public init(
        fetchPopularityPostUseCase: FetchPopularityPostUseCase,
        fetchAreaOfInterestUseCase: FetchAreaOfInteresPostUseCase
    ) {
        self.fetchPopularityPostUseCase = fetchPopularityPostUseCase
        self.fetchAreaOfInterestUseCase = fetchAreaOfInterestUseCase
    }

    let popularityPostData = PublishRelay<PopularityPostEntity>()
    let areaOfInterestPostData = PublishRelay<AreaOfInterestPostEntity>()

    public struct Input {
        let viewWillApper: Observable<Void>
        let showDetailPost: Observable<String>
        let writePostButtonDidClick: Observable<Void>
    }

    public struct Output {
        let popularityPostData: Signal<PopularityPostEntity>
        let areaOfInterestPostData: Signal<AreaOfInterestPostEntity>
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
                self.fetchAreaOfInterestUseCase.excute()
                    .catch {
                        print($0.localizedDescription)
                        return .never()
                    }
            }
            .bind(to: areaOfInterestPostData)
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
            areaOfInterestPostData: areaOfInterestPostData.asSignal()
        )
    }
}
