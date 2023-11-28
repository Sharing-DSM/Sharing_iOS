import Foundation
import RxSwift

public class SearchInPostTitleUseCase {

    private let repository: PostRepository

    public init(repository: PostRepository) {
        self.repository = repository
    }

    public func excute(keyword: String) -> Single<CommonPostEntity> {
        return repository.searchInPostTitle(keyword: keyword)
    }
}
