import Foundation
import RxSwift

public class FetchUserProfileUseCase {

    let repository: ProfileRepository

    public init(repository: ProfileRepository) {
        self.repository = repository
    }

    public func excute() -> Single<UserProfileEntity> {
        return repository.fetchUserProfile()
    }
}
