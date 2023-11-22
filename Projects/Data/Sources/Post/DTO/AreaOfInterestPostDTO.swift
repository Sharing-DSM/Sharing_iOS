import Foundation
import Domain
import Core

public struct AreaOfInterestPostDTOElement: Decodable {

    let id, title, addressName, type: String
    let xAddressName: Double
    let yAddressName: Double

    enum CodingKeys: String, CodingKey {
        case id, title, type
        case addressName = "address_name"
        case xAddressName = "x"
        case yAddressName = "y"
    }
}

public typealias AreaOfInterestPostDTO = [AreaOfInterestPostDTOElement]

extension AreaOfInterestPostDTO {
    func toDomain() -> AreaOfInterestPostEntity {
        return self.map { $0.toDomain() }
    }
}

extension AreaOfInterestPostDTOElement {
    func toDomain() -> AreaOfInterestPostEntityElement {
        return .init(
            id: id,
            title: title,
            addressName: addressName,
            xAddress: xAddressName,
            yAddress: yAddressName,
            type: TagTypeEnum(rawValue: type) ?? .none
        )
    }
}
