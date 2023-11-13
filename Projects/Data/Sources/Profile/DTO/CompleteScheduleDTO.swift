import Foundation
import Domain

public struct CompleteScheduleDTO: Decodable {
    public let id: String
    public let title: String
    public let date: Date
    public let isComplete: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case date
        case isComplete = "is_completed"
    }
}

extension CompleteScheduleDTO {
    public func toDomain() -> CompleteScheduleEntity {
        return .init(
            id: self.id,
            title: self.title,
            date: self.date,
            isCompleted: self.isComplete
        )
    }
}
