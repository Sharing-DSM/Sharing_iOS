import Foundation
import RxSwift

public class FetchApplicantListUseCase {

    private let repository: PostRepository

    public init(repository: PostRepository) {
        self.repository = repository
    }

    public func execute(id: String) -> Single<ApplicantListEntity> {
        return repository.fetchApplicantList(id: id)
    }
}
