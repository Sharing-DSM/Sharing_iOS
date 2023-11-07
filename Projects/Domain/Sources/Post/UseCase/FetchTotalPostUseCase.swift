import Foundation
import RxSwift

public class FetchTotalPostUseCase {

    let repository: PostRepository

    public init(repository: PostRepository) {
        self.repository = repository
    }

    public func excute() -> Single<TotalPostEntity> {
        return repository.fetchTotalPost()
    }
}
