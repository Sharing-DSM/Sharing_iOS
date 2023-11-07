import Foundation
import RxSwift
import Moya
import RxMoya
import AppNetwork
import AppLogger

class AddressDatasource {

    private let provider = MoyaProvider<AddressAPI>(plugins: [MoyaLoggingPlugin()])

    static let shared = AddressDatasource()
    private init() {}

    func fetchAddress(keyword: String, page: Int) -> Single<Response> {
        return provider.rx.request(.fetchAddress(keyword: keyword, page: page))
            .filterSuccessfulStatusCodes()
            .catch { .error($0.toError(AddressError.self)) }
    }
}
