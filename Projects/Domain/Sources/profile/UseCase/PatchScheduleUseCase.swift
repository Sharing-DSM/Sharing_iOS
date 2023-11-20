import Foundation
import RxSwift

public class PatchScheduleUseCase {

    let repository: ProfileRepository

    public init(repository: ProfileRepository) {
        self.repository = repository
    }

    public func excute(id: String, title: String, date: String) -> Completable {
        return repository.patchSchedules(id: id, title: title, date: date)
    }
}
