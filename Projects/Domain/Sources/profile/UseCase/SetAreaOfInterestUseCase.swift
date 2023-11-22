import Foundation
import RxSwift

public class SetAreaOfInterestUseCase {

    let repository: ProfileRepository

    public init(repository: ProfileRepository) {
        self.repository = repository
    }

    public func excute(addressName: String) -> Completable {
        return repository.setAreaOfInterest(addressName: addressName)
    }
}
