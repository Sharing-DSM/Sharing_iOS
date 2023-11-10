import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Domain
import Core

public class PostDetailViewModel: ViewModelType, Stepper {

    public var steps = PublishRelay<Step>()
    public var disposeBag = DisposeBag()

    private let fetchPostDetailUseCase: FetchPostDetailUseCase
    private let deletePostUseCase: DeletePostUseCase

    public init(
        fetchPostDetailUseCase: FetchPostDetailUseCase,
        deletePostUseCase: DeletePostUseCase
    ) {
        self.fetchPostDetailUseCase = fetchPostDetailUseCase
        self.deletePostUseCase = deletePostUseCase
    }

    private let detailData = PublishRelay<PostDetailEntity>()

    public struct Input {
        let fetchDetailView: Observable<String>
        let deletePost: Observable<String>
        let editPost: Observable<String>
    }

    public struct Output {
        let detailData: Signal<PostDetailEntity>
    }
    
    public func transform(input: Input) -> Output {

        input.fetchDetailView
            .flatMap {
                self.fetchPostDetailUseCase.excute(id: $0)
                    .catch {
                        print($0.localizedDescription)
                        return .never()
                    }
            }
            .bind(to: detailData)
            .disposed(by: disposeBag)
        input.deletePost
            .flatMap { id in
                self.deletePostUseCase.excute(id: id)
                    .andThen(Single.just(SharingStep.succeedDeletePostRequired))
                    .catch { .just(SharingStep.errorAlertRequired(content: $0.localizedDescription)) }
            }
            .bind(to: steps)
            .disposed(by: disposeBag)
        
        
        return Output(detailData: detailData.asSignal())
    }
}
