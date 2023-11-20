import Foundation
import Domain

public struct CompleteScheduleDTO: Decodable {
    public let id: String
    public let title: String
    public let date: String
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
        let dateFormatter = DateFormatter()
        let formatDate =  dateFormatter.formatDateString(
            dateString: self.date,
            inputFormat: "yyyy-mm-dd",
            outputFormat: "YYYY년 MM월 dd일"
        )
        return .init(
            id: self.id,
            title: self.title,
            date: formatDate,
            isCompleted: self.isComplete
        )
    }
}
