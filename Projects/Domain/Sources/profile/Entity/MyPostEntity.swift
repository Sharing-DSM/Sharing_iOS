import Foundation
import Core

public class MyPostEntityElement {
    
    public let id: String
    public let title: String
    public let addressName: String
    public let type: TagTypeEnum

    public init(id: String, title: String, addressName: String, type: TagTypeEnum) {
        self.id = id
        self.title = title
        self.addressName = addressName
        self.type = type
    }
}

public typealias MyPostEntity = [MyPostEntityElement]
