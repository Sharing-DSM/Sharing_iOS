public struct ChatContentEntity {
    public let userName: String
    public let chats: [ChatContentEntityElement]

    public init(userName: String, chats: [ChatContentEntityElement]) {
        self.userName = userName
        self.chats = chats
    }
}

public struct ChatContentEntityElement {
    public let roomID: String
    public let isMine: Bool
    public let message, sendAt: String

    public init(roomID: String, isMine: Bool, message: String, sendAt: String) {
        self.roomID = roomID
        self.isMine = isMine
        self.message = message
        self.sendAt = sendAt
    }
}
