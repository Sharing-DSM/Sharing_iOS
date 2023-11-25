import Foundation
import Domain
import Core

public struct UnCompleteScheduleDTO: Decodable {
    public let id: String
    public let title: String
    public let date: String
    public let isComplete: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case date
        case isComplete = "completed"
    }
}

extension UnCompleteScheduleDTO {
    public func toDomain() -> UncompleteScheduleEntity {
        return .init(
            id: self.id,
            title: self.title,
            date: date.toDate(.fullDate).toString("yyyy년 MM월 dd일"),
            isCompleted: self.isComplete
        )
    }
}
