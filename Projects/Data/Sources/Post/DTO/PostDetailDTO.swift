import Foundation
import Domain

struct PostDetailDTO: Decodable {
    let feedID, title, addressName: String
    let recruitment, volunteerTime: Int
    let content: String
    let isMine: Bool

    enum CodingKeys: String, CodingKey {
        case feedID = "feed_id"
        case title
        case addressName = "address_name"
        case recruitment
        case volunteerTime = "volunteer_time"
        case content
        case isMine = "is_mine"
    }
}

extension PostDetailDTO {
    func toDomain() -> PostDetailEntity {
        return .init(
            feedID: feedID,
            title: title,
            addressName: addressName,
            recruitment: recruitment,
            volunteerTime: volunteerTime,
            content: content,
            isMine: isMine
        )
    }
}
