import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Domain
import Core

public class MapViewModel: ViewModelType, Stepper {
    public var steps = PublishRelay<Step>()
    
    public var disposeBag = DisposeBag()

    private let fetchTotalPostUseCase: FetchTotalPostUseCase

    public init(fetchTotalPostUseCase: FetchTotalPostUseCase) {
        self.fetchTotalPostUseCase = fetchTotalPostUseCase
    }

    let totalPostData = PublishRelay<TotalPostEntity>()

    public struct Input {
        let viewDidLoad: Observable<Void>
        let writePostButtonDidClick: Observable<Void>?
        let selectItem: Signal<String>?
    }
    
    public struct Output {
        let totalPostData: Signal<TotalPostEntity>
    }

    public func transform(input: Input) -> Output {

        input.viewDidLoad.asObservable()
            .flatMap {
                self.fetchTotalPostUseCase.excute()
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
