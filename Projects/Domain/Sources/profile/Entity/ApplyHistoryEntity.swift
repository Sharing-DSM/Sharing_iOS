import Foundation
import Core

public struct ApplyHistoryElement {
    public let id: String
    public let feedId: String
    public let title: String
    public let address: String
    public let feedType: TagTypeEnum

    public init(id: String, feedId: String, title: String, address: String, feedType: TagTypeEnum) {
        self.id = id
        self.feedId = feedId
        self.title = title
        self.address = address
        self.feedType = feedType
    }
}

public typealias ApplyHistoryEntity = [ApplyHistoryElement]
