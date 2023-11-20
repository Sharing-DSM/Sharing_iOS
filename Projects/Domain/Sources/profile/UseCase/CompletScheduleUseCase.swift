import Foundation
import RxSwift

public class CompleteScheduleUseCase {

    let repository: ProfileRepository

    public init(repository: ProfileRepository) {
        self.repository = repository
    }

    public func excute(id: String) -> Completable {
        return repository.completSchedules(id: id)
    }
}
