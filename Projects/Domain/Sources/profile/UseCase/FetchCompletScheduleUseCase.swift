import Foundation
import RxSwift

public class FetchCompletScheduleUseCase {

    let repository: ProfileRepository

    public init(repository: ProfileRepository) {
        self.repository = repository
    }

    public func excute() -> Single<[CompleteScheduleEntity]> {
        return repository.fetchCompleteSchedules()
    }
}
