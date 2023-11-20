import Foundation
import RxSwift

public class PatchUserProfileUseCase {

    let repository: ProfileRepository

    public init(repository: ProfileRepository) {
        self.repository = repository
    }

    public func excute(name: String, id: String, age: Int) -> Completable {
        return repository.patchUserProfile(name: name, id: id, age: age)
    }
}
