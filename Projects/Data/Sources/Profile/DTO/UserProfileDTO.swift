import Foundation
import Domain

public struct UserProfileDTO: Decodable {
    let name: String
    let accountId: String
    let age: Int
    let profileImageURL: String

    enum CodingKeys: String, CodingKey {
        case name
        case accountId = "account_id"
        case age
        case profileImageURL = "profile"
    }
}

extension UserProfileDTO {
    func toDomain() -> UserProfileEntity {
        return .init(
            name: name, 
            accountId: accountId,
            age: age,
            profileImageURL: profileImageURL
        )
    }
}
