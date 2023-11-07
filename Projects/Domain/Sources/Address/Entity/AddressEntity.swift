import Foundation

public struct AddressEntity {
    public let totalPage: Int
    public let isPageEnd: Bool
    public let address: [AddressEntityElement]

    public init(totalPage: Int, isPageEnd: Bool, address: [AddressEntityElement]) {
        self.totalPage = totalPage
        self.isPageEnd = isPageEnd
        self.address = address
    }
}

public struct AddressEntityElement {
    public let x, y: Double
    public let addressName, roadAddressName, buildingName: String

    public init(x: Double, y: Double, addressName: String, roadAddressName: String, buildingName: String) {
        self.x = x
        self.y = y
        self.addressName = addressName
        self.roadAddressName = roadAddressName
        self.buildingName = buildingName
    }
}
