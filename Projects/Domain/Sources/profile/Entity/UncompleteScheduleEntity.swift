import Foundation

public struct UncompleteScheduleEntity {
    public let id: String
    public let title: String
    public let date: String
    public let isCompleted: Bool

    public init(id: String, title: String, date: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.date = date
        self.isCompleted = isCompleted
    }
}
