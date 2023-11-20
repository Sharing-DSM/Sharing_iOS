import Foundation
import Domain
import Core

struct ApplyHistoryDTOElement: Decodable {
    let id, feedId, title, feedAddress, type, appliedAt: String
    enum CodingKeys: String, CodingKey {
        case id
        case feedId = "feed_id"
        case title = "feed_title"
        case feedAddress = "feed_address_name"
        case type = "feed_type"
        case appliedAt = "applied_at"
    }
}

typealias ApplyHistoryDTO = [ApplyHistoryDTOElement]

extension ApplyHistoryDTO {
    func toDomain() -> ApplyHistoryEntity {
        return  self.map { $0.toDomain() }
    }
}

extension ApplyHistoryDTOElement {
    func toDomain() -> ApplyHistoryElement {
        return .init(
            id: id,
            feedId: feedId,
            title: title,
            address: feedAddress,
            feedType: TagTypeEnum(rawValue: type) ?? .none
        )
    }
}
