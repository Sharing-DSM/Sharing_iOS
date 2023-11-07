import Foundation
import RxSwift

public class CreatePostUseCase {

    let repository: PostRepository

    public init(repository: PostRepository) {
        self.repository = repository
    }

    public func execute(
        title: String,
        content: String,
        addressData: AddressEntityElement,
        recruitment: Int,
        type: String,
        volunteerTime: Int,
        isEmergency: Bool
    ) -> Completable {
        return repository.createPost(
            title: title,
            content: content,
            addressData: addressData,
            recruitment: recruitment,
            type: type,
            volunteerTime: volunteerTime,
            isEmergency: isEmergency
        )
    }
}
