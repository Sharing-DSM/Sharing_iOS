import Foundation
import Core

public struct SurroundPostEntityElement {
    public let id, title, addressName: String
    public let longitude, latitude: Double
    public let type: TagTypeEnum

    public init(
        id: String,
        title: String,
        addressName: String,
        latitude: Double,
        longitude: Double,
        type: TagTypeEnum
    ) {
        self.id = id
        self.title = title
        self.addressName = addressName
        self.latitude = latitude
        self.longitude = longitude
        self.type = type
    }
}

public typealias SurroundPostEntity = [SurroundPostEntityElement]
