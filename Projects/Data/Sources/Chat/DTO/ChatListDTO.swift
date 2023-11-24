import Foundation
import Domain
import Core

struct ChatListDTO: Decodable {
    let myRoomList: [ChatListDTOMyRoomList]

    enum CodingKeys: String, CodingKey {
        case myRoomList = "my_room_list"
    }
}

struct ChatListDTOMyRoomList: Decodable {
    let roomID, lastChat, lastSendAt: String
    let isRead: Bool
    let roomName, userProfile: String

    enum CodingKeys: String, CodingKey {
        case roomID = "room_id"
        case lastChat = "last_chat"
        case lastSendAt = "last_send_at"
        case isRead = "is_read"
        case roomName = "room_name"
        case userProfile = "user_profile"
    }
}

extension ChatListDTO {
    func toDomain() -> ChatListEntity {
        return .init(
            myRoomList: myRoomList.map { $0.toDomain() }
        )
    }
}

extension ChatListDTOMyRoomList {
    func toDomain() -> ChatListEntityMyRoomList {
        return .init(
            roomID: roomID,
            lastChat: lastChat,
            lastSendAt: lastSendAt.toDate(.fullDateAndTime).toString("a hh:mm"),
            isRead: isRead,
            roomName: roomName,
            userProfile: userProfile
        )
    }
}
