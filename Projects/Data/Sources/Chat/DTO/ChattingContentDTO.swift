import Foundation
import Domain

struct ChattingContentDTO: Decodable {
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

extension ChattingContentDTO {
    func toDomain() -> ChattingContentEntity {
        return .init(
            roomID: roomID,
            isMine: isMine,
            message: message,
            sendAt: sendAt.toDate().toString()
        )
    }
}
