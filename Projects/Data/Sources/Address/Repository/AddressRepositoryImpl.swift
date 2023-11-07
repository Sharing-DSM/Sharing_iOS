import Foundation
import Domain
import RxSwift

class AddressRepositoryImpl: AddressRepository {

    let remoteDatasource = AddressDatasource.shared

    func fetchAddress(keyword: String, page: Int) -> Observable<AddressEntity> {
        remoteDatasource.fetchAddress(keyword: keyword, page: page)
            .map(AddressDTO.self)
            .map { $0.toDomain() }
            .asObservable()
    }
}
