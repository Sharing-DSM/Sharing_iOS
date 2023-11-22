import Foundation
import Domain

struct UploadImageResponseDTO: Decodable {
    let imageUrl: String

    enum CodingKeys: String, CodingKey {
        case imageUrl = "url"
    }
}

extension UploadImageResponseDTO {
    func toDomain() -> UploadImageResponseEntity {
        return .init(imageUrl: imageUrl)
    }
}
