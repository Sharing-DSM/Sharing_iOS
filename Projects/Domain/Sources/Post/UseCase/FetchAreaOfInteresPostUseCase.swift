import Foundation
import RxSwift

public class FetchAreaOfInteresPostUseCase {

    let repository: PostRepository

    public init(repository: PostRepository) {
        self.repository = repository
    }

    public func excute() -> Single<AreaOfInterestPostEntity> {
        return repository.fetchAreaOfInterestPost()
    }
}
