import Foundation
import Core

public struct PopularityPostEntityElement {
    public let id, title, addressName: String
    public let type: TagTypeEnum

    public init(id: String, title: String, addressName: String, type: TagTypeEnum) {
        self.id = id
        self.title = title
        self.addressName = addressName
        self.type = type
    }
}

public typealias PopularityPostEntity = [PopularityPostEntityElement]
