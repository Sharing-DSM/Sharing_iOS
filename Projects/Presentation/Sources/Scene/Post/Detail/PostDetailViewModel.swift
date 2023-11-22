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
    private let postApplicationVolunteerUseCase: PostApplicationVolunteerUseCase

    public init(
        fetchPostDetailUseCase: FetchPostDetailUseCase,
        deletePostUseCase: DeletePostUseCase,
        createChatRoomUseCase: CreateChatRoomUseCase,
        PostApplicationVolunteerUseCase: PostApplicationVolunteerUseCase
    ) {
        self.fetchPostDetailUseCase = fetchPostDetailUseCase
        self.deletePostUseCase = deletePostUseCase
        self.createChatRoomUseCase = createChatRoomUseCase
        self.postApplicationVolunteerUseCase = PostApplicationVolunteerUseCase
    }

    private let detailData = PublishRelay<PostDetailEntity>()
    private let didCreateChatRoom = PublishRelay<ChatRoomIDEntity>()

    public struct Input {
        let fetchDetailView: Observable<String>
        let showApplicantList: Observable<String>
        let deletePost: Observable<String>
        let editPost: Observable<String>
        let chatButtonDidClick: Observable<String>
        let applicationButtonDidClick: Observable<String>
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

        input.showApplicantList
            .map { SharingStep.applicantListRequired(id: $0) }
            .bind(to: steps)
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

        input.applicationButtonDidClick
            .flatMap {
                self.postApplicationVolunteerUseCase.excute(id: $0)
                    .andThen(Single.just(SharingStep.alertRequired(title: "신청 완료", content: "신청이 성공적으로 완료되었습니다.")))
                    .catch { .just(SharingStep.errorAlertRequired(content: $0.localizedDescription)) }
            }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output(
            detailData: detailData.asSignal()
        )
    }
}
