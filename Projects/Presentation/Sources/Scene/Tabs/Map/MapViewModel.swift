import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Domain
import Core

public class MapViewModel: ViewModelType, Stepper {
    public var steps = PublishRelay<Step>()
    
    public var disposeBag = DisposeBag()

    private let fetchSurroundingPostUseCase: FetchSurroundingPostUseCase
    private let fetchPostDetailUseCase: FetchPostDetailUseCase

    public init(
        fetchSurroundingPostUseCase: FetchSurroundingPostUseCase,
        fetchPostDetailUseCase: FetchPostDetailUseCase
    ) {
        self.fetchSurroundingPostUseCase = fetchSurroundingPostUseCase
        self.fetchPostDetailUseCase = fetchPostDetailUseCase
    }

    let surroundPostData = PublishRelay<SurroundPostEntity>()
    let postDetailData = PublishRelay<PostDetailEntity>()
    let dismissPostDetail = PublishRelay<Void>()

    public struct Input {
        let writePostButtonDidClick: Observable<Void>?
        let selectItem: Signal<String>?
        let fetchSurroundingPost: Observable<(x: Double, y: Double)>?
        let dismissPostDetail: Observable<Void>?
    }
    
    public struct Output {
        let surroundPostData: Signal<SurroundPostEntity>
        let postDetailData: Signal<PostDetailEntity>
        let dismissPostDetail: Signal<Void>
    }

    public func transform(input: Input) -> Output {

        input.fetchSurroundingPost?.asObservable()
            .flatMap {
                self.fetchSurroundingPostUseCase.execute(x: $0.x, y: $0.y)
                    .catch {
                        print($0.localizedDescription)
                        return .just([])
                    }
            }
            .bind(to: surroundPostData)
            .disposed(by: disposeBag)

        input.selectItem?.asObservable()
            .flatMap {
                self.fetchPostDetailUseCase.excute(id: $0)
                    .catch {
                        print($0.localizedDescription)
                        return .never()
                    }
            }
            .bind(to: postDetailData)
            .disposed(by: disposeBag)

        input.writePostButtonDidClick?
            .map { _ in SharingStep.postWriteRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)

        input.dismissPostDetail?
            .bind(to: dismissPostDetail)
            .disposed(by: disposeBag)

        return Output(
            surroundPostData: surroundPostData.asSignal(),
            postDetailData: postDetailData.asSignal(),
            dismissPostDetail: dismissPostDetail.asSignal()
        )
    }
}
