import Core
import RxSwift
import RxFlow
import RxCocoa
import Domain

public class MyPostViewModel: ViewModelType, Stepper {
    
    public var steps = RxRelay.PublishRelay<RxFlow.Step>()
    
    public var disposeBag = RxSwift.DisposeBag()
    private let fetchMyPostUseCase: FetchMyPostUseCase

    public init(fetchMyPostUseCase: FetchMyPostUseCase) {
        self.fetchMyPostUseCase = fetchMyPostUseCase
    }

    public struct Input {
        let viewWillAppear: Observable<Void>
        let showDetail: Observable<String>
    }
    public struct Output {
        let myPost: PublishRelay<MyPostEntity>
    }

    public func transform(input: Input) -> Output {
        let myPostData = PublishRelay<MyPostEntity>()
        input.viewWillAppear
            .flatMap {
                self.fetchMyPostUseCase.excute()
            }
            .bind(to: myPostData)
            .disposed(by: disposeBag)
        input.showDetail
            .map {SharingStep.postDetailRequired(id: $0)}
            .bind(to: steps)
            .disposed(by: disposeBag)
        return Output(myPost: myPostData)
    }
}
