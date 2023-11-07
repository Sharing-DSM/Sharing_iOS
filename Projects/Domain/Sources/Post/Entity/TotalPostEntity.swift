import Foundation

public struct TotalPostEntityElement {
    public let id, title, addressName, type: String

    public init(id: String, title: String, addressName: String, type: String) {
        self.id = id
        self.title = title
        self.addressName = addressName
        self.type = type
    }
}

public typealias TotalPostEntity = [TotalPostEntityElement]
