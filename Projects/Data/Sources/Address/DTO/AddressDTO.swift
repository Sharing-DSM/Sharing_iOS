import Foundation
import Domain

struct AddressDTO: Decodable {
    let totalPage: Int
    let isPageEnd: Bool
    let address: [AddressDTOElement]

    enum CodingKeys: String, CodingKey {
        case totalPage = "total_page"
        case isPageEnd = "is_page_end"
        case address
    }
}

struct AddressDTOElement: Decodable {
    let x, y: Double
    let addressName, roadAddressName, buildingName: String

    enum CodingKeys: String, CodingKey {
        case x, y
        case addressName = "address_name"
        case roadAddressName = "road_address_name"
        case buildingName = "building_name"
    }
}

extension AddressDTO {
    func toDomain() -> AddressEntity {
        return .init(
            totalPage: totalPage,
            isPageEnd: isPageEnd,
            address: address.map { $0.toDomain() }
        )
    }
}

extension AddressDTOElement {
    func toDomain() -> AddressEntityElement {
        return .init(
            x: x,
            y: y,
            addressName: addressName,
            roadAddressName: roadAddressName,
            buildingName: buildingName
        )
    }
}
