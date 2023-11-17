import Foundation
import Domain

public struct UnCompleteScheduleListDTO: Decodable {
    let unCompletScheduleList: [UnCompleteScheduleDTO]

    enum CodingKeys: String, CodingKey {
        case unCompletScheduleList = "schedule_list"
    }
}

extension UnCompleteScheduleListDTO {
    public func toDomain() -> [UncompleteScheduleEntity] {
        return self.unCompletScheduleList.map {
            $0.toDomain()
        }
    }
}
