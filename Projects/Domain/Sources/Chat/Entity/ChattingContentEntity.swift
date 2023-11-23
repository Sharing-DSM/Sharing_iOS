import Foundation

public struct ChattingContentEntity {
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
