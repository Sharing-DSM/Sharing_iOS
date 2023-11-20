import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Core
import Domain

public class ChatRoomViewModel: ViewModelType, Stepper {
    
    public var steps = PublishRelay<Step>()
    public var disposeBag = DisposeBag()
    
    private let chattingUseCase: ChattingUseCase
    
    public init(chattingUseCase: ChattingUseCase) {
        self.chattingUseCase = chattingUseCase
        chattingUseCase.chatContent.asObservable()
            .bind(to: chattingMessage)
            .disposed(by: disposeBag)
    }
    
    private let chatContent = PublishRelay<ChatContentEntity>()
    private let chattingMessage = PublishRelay<ChattingContentEntity>()
    
    public struct Input {
        let fetchChatContent: Observable<String>
        let joinChatRoom: Observable<String>
        let exitChatRoom: Observable<Void>
        let sendChatting: Observable<String>
    }
    
    public struct Output {
        let joinRoom: Signal<ChatContentEntity>
        let chattingMassage: Signal<ChattingContentEntity>
    }
    
    public func transform(input: Input) -> Output {
        
        input.sendChatting.asObservable()
            .subscribe(
                with: self,
                onNext: { owner, content in
                    owner.chattingUseCase.sendChat(content: content)
                }
            )
            .disposed(by: disposeBag)
        
        input.exitChatRoom.asObservable()
            .subscribe(
                with: self,
                onNext: { owner, _ in
                    owner.chattingUseCase.exitChatRoom()
                }
            )
            .disposed(by: disposeBag)
        
        input.joinChatRoom.asObservable()
            .subscribe(
                with: self,
                onNext: { owner, roomID in
                    owner.chattingUseCase.joinChatRoom(roomID: roomID)
                }
            )
            .disposed(by: disposeBag)
        
        input.fetchChatContent
            .flatMap {
                self.chattingUseCase.fetchChatContent(roomID: $0)
                    .catch {
                        print($0.localizedDescription)
                        return .never()
                    }
            }
            .bind(to: chatContent)
            .disposed(by: disposeBag)
        
        return Output(
            joinRoom: chatContent.asSignal(),
            chattingMassage: chattingMessage.asSignal()
        )
    }
}
