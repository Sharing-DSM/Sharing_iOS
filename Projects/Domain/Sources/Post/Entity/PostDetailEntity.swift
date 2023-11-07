import Foundation

public struct PostDetailEntity {
    public let feedID, title, addressName: String
    public let recruitment, volunteerTime: Int
    public let content: String
    public let isMine: Bool

    public init(feedID: String, title: String, addressName: String, recruitment: Int, volunteerTime: Int, content: String, isMine: Bool) {
        self.feedID = feedID
        self.title = title
        self.addressName = addressName
        self.recruitment = recruitment
        self.volunteerTime = volunteerTime
        self.content = content
        self.isMine = isMine
    }
}
