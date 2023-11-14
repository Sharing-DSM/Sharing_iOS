import Foundation
import Domain
import Core

struct SurroundPostDTOElement: Decodable {
    let id, title, addressName: String
    let x, y: Double
    let type: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case addressName = "address_name"
        case x, y, type
    }
}

typealias SurroundPostDTO = [SurroundPostDTOElement]

extension SurroundPostDTO {
    func toDomain() -> SurroundPostEntity {
        return self.map { $0.toDomain() }
    }
}

extension SurroundPostDTOElement {
    func toDomain() -> SurroundPostEntityElement {
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
