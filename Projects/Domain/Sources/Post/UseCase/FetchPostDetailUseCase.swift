import Foundation
import RxSwift

public class FetchPostDetailUseCase {

    private let repository: PostRepository

    public init(repository: PostRepository) {
        self.repository = repository
    }

    public func excute(id: String) -> Single<PostDetailEntity> {
        return repository.fetchDetailPost(id: id)
    }
}
