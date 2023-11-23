import Foundation
import RxSwift
import RxCocoa
import SocketIO
import AppNetwork
import Core
import Domain

class ChatSocketDataSource {

    static let shared = ChatSocketDataSource()

    let chatConent = PublishRelay<ChattingContentEntity>()

    private var socket: SocketIOClient!
    private let socketManager = SocketManager(
        socketURL: URLUtil.socketURL,
        config: [.log(true), .compress]
    )

    func connectSocket() {
        socketManager.config = SocketIOClientConfiguration(
            arrayLiteral:
            .extraHeaders(TokenStorage.shared.toHeader(.accessToken)),
            .version(.two),
            .path("/socket.io"),
            .reconnects(true)
        )
        self.socket = socketManager.defaultSocket
        socket.connect()
        onChat()
    }

    func disconnectSocket(completion: @escaping () -> Void) {
        socket.disconnect()
        completion()
    }

    func joinChatRoom(roomID: String) {
        socket.emit("join", ["room_id" : roomID, "is_join_room" : true])
    }

    func exitChatRoom() {
        socket.emit("join", ["is_join_room" : false])
    }

    func sendChat(content : String) {
        socket.emit("chat", ["message" : content])
    }

    func onChat() {
        socket.on("chat") { [weak self] dataArr, _ in
            guard let self = self,
                  let content = dataArr.first as? String,
                  let data = content.data(using: .utf8),
                  let chatData = try? JSONDecoder().decode(ChattingContentDTO.self, from: data)
            else { return }
            chatConent.accept(chatData.toDomain())
        }
    }
}
