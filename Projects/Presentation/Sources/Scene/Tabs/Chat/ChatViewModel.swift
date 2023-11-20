import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Core
import Domain

public class ChatViewModel: ViewModelType, Stepper {
    
    public var steps = PublishRelay<Step>()
    public var disposeBag = DisposeBag()
    
    private let fetchChatRoomListUseCase: FetchChatRoomListUseCase
    private let chattingUseCase : ChattingUseCase
    
    public init(fetchChatRoomListUseCase: FetchChatRoomListUseCase, chattingUseCase: ChattingUseCase) {
        self.fetchChatRoomListUseCase = fetchChatRoomListUseCase
        self.chattingUseCase = chattingUseCase
        subscribeChatting()
    }
    
    private let chatRoomsData = PublishRelay<[ChatListEntityMyRoomList]>()
    private let chattingMessage = PublishRelay<ChattingContentEntity>()
    
    public struct Input {
        let fetchChatRoomList: Observable<Void>
        let selectChatRoom: Observable<String>
    }
    
    public struct Output {
        let chatRoomsData: Signal<[ChatListEntityMyRoomList]>
        let chattingMassage: Signal<ChattingContentEntity>
    }
    
    public func transform(input: Input) -> Output {

        input.fetchChatRoomList
            .flatMap {
                self.fetchChatRoomListUseCase.execute()
                    .catch {
                        print($0.localizedDescription)
                        return .never()
                    }
            }
            .map { $0.myRoomList }
            .bind(to: chatRoomsData)
            .disposed(by: disposeBag)
        
        input.selectChatRoom
            .map { SharingStep.chatRoomRequired(roomID: $0) }
            .bind(to: steps)
            .disposed(by: disposeBag)
        
        return Output(
            chatRoomsData: chatRoomsData.asSignal(),
            chattingMassage: chattingMessage.asSignal()
        )
    }
    
    private func subscribeChatting() {
        let chatData = Observable.combineLatest(chattingUseCase.chatContent, chatRoomsData) { (chattingData: $0, roomList: $1) }
        
        chattingUseCase.chatContent.asObservable()
            .withLatestFrom(chatData)
            .subscribe(
                with: self,
                onNext: { owner, source in
                    let originIndex = source.roomList.firstIndex { $0.roomID == source.chattingData.roomID }
                    guard let originIndex = originIndex else { return }
                    var returnList = source.roomList
                    let inputData: ChatListEntityMyRoomList = .init(
                        roomID: source.chattingData.roomID,
                        lastChat: source.chattingData.message,
                        lastSendAt: source.chattingData.sendAt,
                        isRead: false,
                        roomName: source.roomList[originIndex].roomName
                    )
                    returnList.remove(at: originIndex)
                    returnList.insert(inputData, at: 0)
                    owner.chatRoomsData.accept(returnList)
                }
            )
            .disposed(by: disposeBag)
    }
}
