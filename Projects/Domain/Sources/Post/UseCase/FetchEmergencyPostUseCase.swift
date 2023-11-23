import Foundation
import RxSwift

public class FetchEmergencyPostUseCase {

    private let repository: PostRepository

    public init(repository: PostRepository) {
        self.repository = repository
    }

    public func excute() -> Single<CommonPostEntity> {
        return repository.fetchEmergencyPost()
    }
}
