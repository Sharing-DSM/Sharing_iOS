import Foundation
import RxSwift

public class SearchInMapUseCase {

    private let repository: PostRepository

    public init(repository: PostRepository) {
        self.repository = repository
    }

    public func excute(keyword: String, x: Double, y: Double) -> Single<CommonPostEntity> {
        return repository.searchInMap(keyword: keyword, x: x, y: y)
    }
}
