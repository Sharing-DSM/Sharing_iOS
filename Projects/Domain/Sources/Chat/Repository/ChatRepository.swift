import Foundation
import RxSwift
import RxCocoa

public protocol ChatRepository {
    var chatContent: PublishRelay<ChattingContentEntity> { get }

    func connectSocket()
    func createChatRoom(userID: String) -> Single<ChatRoomIDEntity>
    func fetchChatList() -> Single<ChatListEntity>
    func fetchChatContent(roomID: String) -> Single<ChatContentEntity>
    func joinChatRoom(roomID: String)
    func exitChatRoom()
    func sendChat(content: String)
}
