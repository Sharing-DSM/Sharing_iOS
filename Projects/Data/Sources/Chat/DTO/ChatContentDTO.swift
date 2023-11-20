import Foundation
import Domain

struct ChatContentDTO: Decodable {
    let userName: String
    let chats: [ChatContentDTOElement]

    enum CodingKeys: String, CodingKey {
        case userName = "user_name"
        case chats
    }
}

struct ChatContentDTOElement: Decodable {
    let roomID: String
    let isMine: Bool
    let message, sendAt: String

    enum CodingKeys: String, CodingKey {
        case roomID = "room_id"
        case isMine = "is_mine"
        case message
        case sendAt = "send_at"
    }
}

extension ChatContentDTO {
    func toDomain() -> ChatContentEntity {
        return .init(
            userName: userName,
            chats: chats.map { $0.toDomain() }
        )
    }
}

extension ChatContentDTOElement {
    func toDomain() -> ChatContentEntityElement {
        return .init(
            roomID: roomID,
            isMine: isMine,
            message: message,
            sendAt: sendAt.toDate().toString()
        )
    }
}
