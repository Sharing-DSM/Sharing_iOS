import Foundation
import RxSwift

public class FetchUnCompleteScheduleUseCase {

    let repository: ProfileRepository

    public init(repository: ProfileRepository) {
        self.repository = repository
    }

    public func excute() -> Single<[UncompleteScheduleEntity]> {
        return repository.fetchUnCompleteSchedules()
    }
}
