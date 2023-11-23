import Foundation
import RxSwift

public class PatchPostUseCase {

    private let repository: PostRepository

    public init(repository: PostRepository) {
        self.repository = repository
    }

    public func execute(
        id: String,
        title: String,
        content: String,
        addressName: String,
        roadAddressName: String,
        xCos: Double,
        yCos: Double,
        recruitment: Int,
        type: String,
        volunteerTime: Int,
        isEmergency: Bool
    ) -> Completable {
        return repository.editPost(
            id: id,
            title: title,
            content: content,
            addressName: addressName,
            roadAddressName: roadAddressName,
            xCos: xCos,
            yCos: yCos,
            recruitment: recruitment,
            type: type,
            volunteerTime: volunteerTime,
            isEmergency: isEmergency
        )
    }
}
