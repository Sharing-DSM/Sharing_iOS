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
    private let createChatRoomUseCase: CreateChatRoomUseCase
    private let searchInMapUseCase: SearchInMapUseCase
    private let postApplicationVolunteerUseCase: PostApplicationVolunteerUseCase

    public init(
        fetchSurroundingPostUseCase: FetchSurroundingPostUseCase,
        fetchPostDetailUseCase: FetchPostDetailUseCase,
        createChatRoomUseCase: CreateChatRoomUseCase,
        searchInMapUseCase: SearchInMapUseCase,
        postApplicationVolunteerUseCase: PostApplicationVolunteerUseCase
    ) {
        self.fetchSurroundingPostUseCase = fetchSurroundingPostUseCase
        self.fetchPostDetailUseCase = fetchPostDetailUseCase
        self.createChatRoomUseCase = createChatRoomUseCase
        self.searchInMapUseCase = searchInMapUseCase
        self.postApplicationVolunteerUseCase = postApplicationVolunteerUseCase
    }

    let surroundPostData = PublishRelay<CommonPostEntity>()
    let postDetailData = PublishRelay<PostDetailEntity>()
    let dismissPostDetail = PublishRelay<Void>()

    public struct Input {
        let writePostButtonDidClick: Observable<Void>?
        let selectItem: Signal<String>?
        let fetchSurroundingPost: Observable<(x: Double, y: Double)>?
        let dismissPostDetail: Observable<Void>?
        let createChatRoom: Observable<String>?
        let applicationVolunteer: Observable<String>?
        let searchPost: Observable<(keyword: String, x: Double, y: Double)>?
    }
    
    public struct Output {
        let surroundPostData: Signal<CommonPostEntity>
        let postDetailData: Signal<PostDetailEntity>
        let dismissPostDetail: Signal<Void>
    }

    public func transform(input: Input) -> Output {

        input.searchPost?.asObservable()
            .flatMap {
                self.searchInMapUseCase.excute(keyword: $0.keyword, x: $0.x, y: $0.y)
                    .catch {
                        print($0.localizedDescription)
                        return .never()
                    }
            }
            .bind(to: surroundPostData)
            .disposed(by: disposeBag)

        input.writePostButtonDidClick?
            .map { SharingStep.postWriteRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)

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

        input.createChatRoom?
            .flatMap {
                self.createChatRoomUseCase.execute(userID: $0)
                    .catch {
                        print($0.localizedDescription)
                        TabBarManager.shared.selectIndex(index: 2)
                        return .never()
                    }
            }
            .subscribe(
                with: self,
                onNext: { owner, data in
                    owner.steps.accept(SharingStep.chatRoomRequired(roomID: data.roomID))
                }
            )
            .disposed(by: disposeBag)

        input.applicationVolunteer?
            .flatMap {
                self.postApplicationVolunteerUseCase.excute(id: $0)
                    .andThen(Single.just(SharingStep.alertRequired(title: "신청 완료", content: "신청이 성공적으로 완료되었습니다.")))
                    .catch { .just(SharingStep.errorAlertRequired(content: $0.localizedDescription)) }
            }
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
