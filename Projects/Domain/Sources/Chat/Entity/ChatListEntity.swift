import Foundation

public struct ChatListEntity {
    public let myRoomList: [ChatListEntityMyRoomList]

    public init(myRoomList: [ChatListEntityMyRoomList]) {
        self.myRoomList = myRoomList
    }
}

public struct ChatListEntityMyRoomList {
    public let roomID, lastChat, lastSendAt: String
    public let isRead: Bool
    public let roomName, userProfile: String

    public init(
        roomID: String,
        lastChat: String,
        lastSendAt: String,
        isRead: Bool,
        roomName: String,
        userProfile: String
    ) {
        self.roomID = roomID
        self.lastChat = lastChat
        self.lastSendAt = lastSendAt
        self.isRead = isRead
        self.roomName = roomName
        self.userProfile = userProfile
    }
}
