import Foundation
import RxSwift

public protocol AddressRepository {
    func fetchAddress(keyword: String, page: Int) -> Observable<AddressEntity>
}
