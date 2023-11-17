import Foundation
import RxSwift

public class DeleteScheduleUseCase {

    let repository: ProfileRepository

    public init(repository: ProfileRepository) {
        self.repository = repository
    }

    public func excute(id: String) -> Completable {
        return repository.deleteSchedules(id: id)
    }
}
