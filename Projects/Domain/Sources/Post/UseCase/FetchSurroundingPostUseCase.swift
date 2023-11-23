import Foundation
import RxSwift

public class FetchSurroundingPostUseCase {

    private let repository: PostRepository

    public init(repository: PostRepository) {
        self.repository = repository
    }

    public func execute(x: Double, y: Double) -> Single<CommonPostEntity> {
        return repository.fetchSurroundingPost(x: x, y: y)
    }
}
