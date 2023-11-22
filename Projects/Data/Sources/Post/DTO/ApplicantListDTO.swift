import Foundation
import Domain

struct ApplicantListDTOElement: Decodable {
    let userID: String
    let userProfile: String
    let userName, appliedAt: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case userProfile = "user_profile"
        case userName = "user_name"
        case appliedAt = "applied_at"
    }
}

typealias ApplicantListDTO = [ApplicantListDTOElement]

extension ApplicantListDTOElement {
    func toDomain() -> ApplicantListEntityElement {
        return .init(
            userID: userID,
            userProfile: userProfile,
            userName: userName,
            appliedAt: appliedAt.toDate(.fullDateAndTime).toString("yyyy.MM.dd")
        )
    }
}

extension ApplicantListDTO {
    func toDomain() -> ApplicantListEntity {
        return self.map { $0.toDomain() }
    }
}
