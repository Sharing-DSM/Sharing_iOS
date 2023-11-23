import Foundation
import Domain

struct ChatRoomIDDTO: Decodable {
    let roomID: String

    enum CodingKeys: String, CodingKey {
        case roomID = "room_id"
    }
}

extension ChatRoomIDDTO {
    func toDomain() -> ChatRoomIDEntity {
        return .init(roomID: roomID)
    }
}
