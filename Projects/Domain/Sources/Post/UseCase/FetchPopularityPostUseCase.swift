import Foundation
import RxSwift

public class FetchPopularityPostUseCase {

    let repository: PostRepository

    public init(repository: PostRepository) {
        self.repository = repository
    }

    public func excute() -> Single<PopularityPostEntity> {
        return repository.fetchPopularityPost()
    }
}
