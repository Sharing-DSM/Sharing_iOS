import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Domain
import Core

public class MapViewModel: ViewModelType, Stepper {
    public var steps = PublishRelay<Step>()
    
    public var disposeBag = DisposeBag()

    private let fetchPopularityPostUseCase: FetchPopularityPostUseCase

    public init(fetchTotalPostUseCase: FetchPopularityPostUseCase) {
        self.fetchPopularityPostUseCase = fetchTotalPostUseCase
    }

    let totalPostData = PublishRelay<PopularityPostEntity>()

    public struct Input {
        let viewDidLoad: Observable<Void>?
        let writePostButtonDidClick: Observable<Void>?
        let selectItem: Signal<String>?
    }
    
    public struct Output {
        let totalPostData: Signal<PopularityPostEntity>
    }

    public func transform(input: Input) -> Output {

        input.viewDidLoad?.asObservable()
            .flatMap {
                self.fetchPopularityPostUseCase.excute()
                    .catch {
                        print($0.localizedDescription)
                        return .just([])
                    }
            }
            .bind(to: totalPostData)
            .disposed(by: disposeBag)

        input.selectItem?.asObservable()
            .map { SharingStep.postDetailRequired(id: $0) }
            .bind(to: steps)
            .disposed(by: disposeBag)

        input.writePostButtonDidClick?
            .map { _ in SharingStep.postWriteRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output(totalPostData: totalPostData.asSignal())
    }
}
