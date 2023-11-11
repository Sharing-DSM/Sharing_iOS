import Foundation
import Domain
import Core

struct PostDetailDTO: Decodable {
    let feedID, title, addressName, roadAddressName, content, userID, type: String
    let x, y: Double
    let recruitment, volunteerTime: Int
    let isEmergency, isMine: Bool

    enum CodingKeys: String, CodingKey {
            case feedID = "feed_id"
            case title
            case addressName = "address_name"
            case roadAddressName = "road_address_name"
            case x, y, recruitment
            case volunteerTime = "volunteer_time"
            case content
            case isEmergency = "is_emergency"
            case isMine = "is_mine"
            case userID = "user_id"
            case type
        }
}

extension PostDetailDTO {
    func toDomain() -> PostDetailEntity {
        return .init(
            feedID: feedID,
            title: title,
            addressName: addressName,
            roadAddressName: roadAddressName,
            content: content,
            userID: userID,
            x: x,
            y: y,
            recruitment: recruitment,
            volunteerTime: volunteerTime,
            isEmergency: isEmergency,
            isMine: isMine,
            type: TagTypeEnum(rawValue: type) ?? .none
        )
    }
}
