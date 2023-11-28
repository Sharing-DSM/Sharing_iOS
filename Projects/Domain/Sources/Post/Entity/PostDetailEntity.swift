import Foundation
import Core

public struct PostDetailEntity {
    public let feedID, title, addressName, roadAddressName, content, userID, userProfile: String
    public let x, y: Double
    public let recruitment, volunteerTime: Int
    public let isEmergency, isMine: Bool
    public let type: TagTypeEnum

    public init(
        feedID: String,
        title: String,
        addressName: String,
        roadAddressName: String,
        content: String,
        userID: String,
        x: Double,
        y: Double,
        recruitment: Int,
        volunteerTime: Int,
        isEmergency: Bool,
        isMine: Bool,
        type: TagTypeEnum,
        userProfile: String
    ) {
        self.feedID = feedID
        self.title = title
        self.addressName = addressName
        self.roadAddressName = roadAddressName
        self.content = content
        self.userID = userID
        self.x = x
        self.y = y
        self.recruitment = recruitment
        self.volunteerTime = volunteerTime
        self.isEmergency = isEmergency
        self.isMine = isMine
        self.type = type
        self.userProfile = userProfile
    }
}
