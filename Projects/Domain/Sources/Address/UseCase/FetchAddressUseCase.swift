import Foundation
import RxSwift

public class FetchAddressUseCase {

    let repository: AddressRepository

    public init(repository: AddressRepository) {
        self.repository = repository
    }

    public func execute(keyword: String, page: Int) -> Observable<AddressEntity> {
        repository.fetchAddress(keyword: keyword, page: page)
    }
}
