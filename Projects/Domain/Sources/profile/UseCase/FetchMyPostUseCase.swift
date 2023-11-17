import Foundation
import RxSwift

public class FetchMyPostUseCase {

    let repository: ProfileRepository

    public init(repository: ProfileRepository) {
        self.repository = repository
    }

    public func excute() -> Single<MyPostEntity> {
        return repository.fetchMyPost()
    }
}
