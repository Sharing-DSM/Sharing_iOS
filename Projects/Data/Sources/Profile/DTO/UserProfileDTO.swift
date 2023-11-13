import Foundation
import Domain

public struct UserProfileDTO: Decodable {
    let name: String
    let accountId: String

    enum CodingKeys: String, CodingKey {
        case name
        case accountId = "account_id"
    }
}

extension UserProfileDTO {
    func toDomain() -> UserProfileEntity {
        return .init(
            name: name, 
            accountId: accountId
        )
    }
}
