import Foundation
import RxSwift

public class PostScheduleUseCase {

    let repository: ProfileRepository

    public init(repository: ProfileRepository) {
        self.repository = repository
    }

    public func excute(title: String, date: String) -> Completable {
        return repository.postSchedules(title: title, date: date)
    }
}
