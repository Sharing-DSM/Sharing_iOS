import Foundation
import RxSwift

public class FetchApplyHistoryUseCase {

    let repository: ProfileRepository

    public init(repository: ProfileRepository) {
        self.repository = repository
    }

    public func excute() -> Single<ApplyHistoryEntity> {
        return repository.fetchApplyHistory()
    }
}
