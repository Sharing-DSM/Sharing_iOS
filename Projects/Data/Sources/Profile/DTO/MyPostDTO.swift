import Foundation
import Domain
import Core

struct MyPostDTOElement: Decodable {
    let id, title, addressName, type: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case addressName = "address_name"
        case type
    }
}

typealias MyPostDTO = [MyPostDTOElement]

extension MyPostDTO {
    func toDomain() -> MyPostEntity {
        return self.map { $0.toDomain() }
    }
}

extension MyPostDTOElement {
    func toDomain() -> MyPostEntityElement {
        return .init(
            id: id,
            title: title,
            addressName: addressName,
            type: TagTypeEnum(rawValue: type) ?? .none
        )
    }
}
