import Foundation
import RxSwift
import RxCocoa

public class ChattingUseCase {

    let repository: ChatRepository

    public let chatContent: PublishRelay<ChattingContentEntity>

    public init(repository: ChatRepository) {
        self.repository = repository
        self.chatContent = repository.chatContent
    }

    public func connectSocket() {
        repository.connectSocket()
    }

    public func sendChat(content: String) {
        repository.sendChat(content: content)
    }

    public func joinChatRoom(roomID: String) {
        repository.joinChatRoom(roomID: roomID)
    }

    public func exitChatRoom() {
        repository.exitChatRoom()
    }

    public func fetchChatContent(roomID: String) -> Single<ChatContentEntity> {
        repository.fetchChatContent(roomID: roomID)
    }
}
