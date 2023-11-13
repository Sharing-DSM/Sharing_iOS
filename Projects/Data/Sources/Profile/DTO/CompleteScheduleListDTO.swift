import Foundation
import Domain

public struct CompleteScheduleListDTO: Decodable {
    let completScheduleList: [CompleteScheduleDTO]

    enum CodingKeys: String, CodingKey {
        case completScheduleList = "schedule_list"
    }
}

extension CompleteScheduleListDTO {
   public func toDomain() -> [CompleteScheduleEntity] {
        return self.completScheduleList.map {
            $0.toDomain()
        }
    }
}
