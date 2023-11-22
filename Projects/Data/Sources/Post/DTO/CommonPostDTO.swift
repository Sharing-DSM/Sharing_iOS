import Foundation
import Domain
import Core

struct CommonPostDTOElement: Decodable {
    let id, title, addressName: String
    let x, y: Double
    let type: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case addressName = "address_name"
        case x, y, type
    }
}

typealias CommonPostDTO = [CommonPostDTOElement]

extension CommonPostDTO {
    func toDomain() -> CommonPostEntity {
        return self.map { $0.toDomain() }
    }
}

extension CommonPostDTOElement {
    func toDomain() -> CommonPostEntityElement {
        return .init(
            id: id,
            title: title,
            addressName: addressName,
            latitude: y,
            longitude: x,
            type: TagTypeEnum(rawValue: type) ?? .none
        )
    }
}
