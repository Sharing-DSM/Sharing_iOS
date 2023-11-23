import Foundation
import RxSwift

public class UploadImageUseCase {

    let repository: ProfileRepository

    public init(repository: ProfileRepository) {
        self.repository = repository
    }

    public func excute(imageData: Data) -> Single<UploadImageResponseEntity> {
        return repository.uploadImage(imageData: imageData)
    }
}
