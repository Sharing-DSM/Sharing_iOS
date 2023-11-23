import Foundation
import Core

public struct AreaOfInterestPostEntityElement {

    public let id: String
    public let title: String
    public let addressName: String
    public let xAddress: Double
    public let yAddress: Double
    public let type: TagTypeEnum

    public init(
        id: String,
        title: String,
        addressName: String,
        xAddress: Double,
        yAddress: Double,
        type: TagTypeEnum
    ) {
        self.id = id
        self.title = title
        self.addressName = addressName
        self.xAddress = xAddress
        self.yAddress = yAddress
        self.type = type
    }
}

public typealias AreaOfInterestPostEntity = [AreaOfInterestPostEntityElement]
