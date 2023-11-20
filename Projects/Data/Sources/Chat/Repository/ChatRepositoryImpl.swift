import Foundation
import RxSwift
import RxCocoa
import Domain

class ChatRepositoryImpl: ChatRepository {

    let remoteDataSource = ChatDataSource.shared
    let socketDataSource = ChatSocketDataSource.shared

    lazy var chatContent = socketDataSource.chatConent

    func createChatRoom(userID: String) -> Single<ChatRoomIDEntity> {
        return remoteDataSource.createChatRoom(userID: userID)
            .map(ChatRoomIDDTO.self)
            .map { $0.toDomain() }
    }

    func fetchChatList() -> Single<ChatListEntity> {
        return remoteDataSource.fetchChatList()
            .map(ChatListDTO.self)
            .map { $0.toDomain() }
    }

    func fetchChatContent(roomID: String) -> Single<ChatContentEntity> {
        return remoteDataSource.fetchChatContent(roomID: roomID)
            .map(ChatContentDTO.self)
            .map { $0.toDomain() }
    }

    func joinChatRoom(roomID: String) {
        socketDataSource.joinChatRoom(roomID: roomID)
    }

    func exitChatRoom() {
        socketDataSource.exitChatRoom()
    }

    func sendChat(content: String) {
        socketDataSource.sendChat(content: content)
    }

    func connectSocket() {
        socketDataSource.connectSocket()
    }
}
