import Foundation
import RxSwift

public class DeletePostUseCase {

    private let repository: PostRepository

    public init(repository: PostRepository) {
        self.repository = repository
    }

    public func excute(id: String) -> Completable {
        return repository.deletePost(id: id)
    }
}
