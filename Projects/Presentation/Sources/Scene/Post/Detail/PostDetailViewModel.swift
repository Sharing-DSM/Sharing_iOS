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
    private let createChatRoomUseCase: CreateChatRoomUseCase

    public init(
        fetchPostDetailUseCase: FetchPostDetailUseCase,
        deletePostUseCase: DeletePostUseCase,
        createChatRoomUseCase: CreateChatRoomUseCase
    ) {
        self.fetchPostDetailUseCase = fetchPostDetailUseCase
        self.deletePostUseCase = deletePostUseCase
        self.createChatRoomUseCase = createChatRoomUseCase
    }

    private let detailData = PublishRelay<PostDetailEntity>()
    private let didCreateChatRoom = PublishRelay<ChatRoomIDEntity>()

    public struct Input {
        let fetchDetailView: Observable<String>
        let deletePost: Observable<String>
        let editPost: Observable<String>
        let chatButtonDidClick: Observable<String>
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
                    .andThen(Single.just(SharingStep.popRequired))
                    .catch { .just(SharingStep.errorAlertRequired(content: $0.localizedDescription)) }
            }
            .bind(to: steps)
            .disposed(by: disposeBag)

        input.editPost
            .map { SharingStep.postEditRequired(id: $0) }
            .bind(to: steps)
            .disposed(by: disposeBag)

        input.chatButtonDidClick
            .flatMap {
                self.createChatRoomUseCase.execute(userID: $0)
                    .catch {
                        print($0.localizedDescription)
                        return .error($0)
                    }
            }
            .subscribe(
                with: self,
                onNext: { owner, data in
                    owner.steps.accept(SharingStep.chatRoomRequired(roomID: data.roomID))
                }, onError: { _, _ in
                    TabBarManager.shared.selectIndex(index: 2)
                }
            )
            .disposed(by: disposeBag)

        return Output(
            detailData: detailData.asSignal()
        )
    }
}
