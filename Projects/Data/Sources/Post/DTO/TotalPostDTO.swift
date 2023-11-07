import Foundation
import Domain

struct TotalPostDTOElement: Decodable {
    let id, title, addressName, type: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case addressName = "address_name"
        case type
    }
}

typealias TotalPostDTO = [TotalPostDTOElement]

extension TotalPostDTO {
    func toDomain() -> TotalPostEntity {
        return self.map { $0.toDomain() }
    }
}

extension TotalPostDTOElement {
    func toDomain() -> TotalPostEntityElement {
        return .init(
            id: id,
            title: title,
            addressName: addressName,
            type: type
        )
    }
}
