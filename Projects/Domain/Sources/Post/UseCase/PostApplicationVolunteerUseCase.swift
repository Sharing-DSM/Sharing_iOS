import Foundation
import RxSwift

public class PostApplicationVolunteerUseCase {

    private let repository: PostRepository

    public init(repository: PostRepository) {
        self.repository = repository
    }

    public func excute(id: String) -> Completable {
        return repository.postApplicationVolunteer(id: id)
    }
}
