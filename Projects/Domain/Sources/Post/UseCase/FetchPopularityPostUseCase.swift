import Foundation
import RxSwift

public class FetchPopularityPostUseCase {

    private let repository: PostRepository

    public init(repository: PostRepository) {
        self.repository = repository
    }

    public func excute() -> Single<PopularityPostEntity> {
        return repository.fetchPopularityPost()
    }
}
