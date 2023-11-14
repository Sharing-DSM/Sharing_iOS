import Foundation

public struct CompleteScheduleEntity {
    public let id: String
    public let title: String
    public let date: Date
    public let isCompleted: Bool

    public init(id: String, title: String, date: Date, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.date = date
        self.isCompleted = isCompleted
    }
}
