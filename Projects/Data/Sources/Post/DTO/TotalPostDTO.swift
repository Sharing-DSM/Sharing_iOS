import Foundation
import Domain
import Core

struct PopularityPostDTOElement: Decodable {
    let id, title, addressName, type: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case addressName = "address_name"
        case type
    }
}

typealias PopularityPostDTO = [PopularityPostDTOElement]

extension PopularityPostDTO {
    func toDomain() -> PopularityPostEntity {
        return self.map { $0.toDomain() }
    }
}

extension PopularityPostDTOElement {
    func toDomain() -> PopularityPostEntityElement {
        return .init(
            id: id,
            title: title,
            addressName: addressName,
            type: TagTypeEnum(rawValue: type) ?? .none
        )
    }
}
