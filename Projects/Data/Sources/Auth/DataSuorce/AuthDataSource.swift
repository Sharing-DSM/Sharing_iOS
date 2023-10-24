import Foundation
import RxSwift
import Moya
import RxMoya
import AppNetwork
import AppLogger

class AuthDataSource {

    private let provider = MoyaProvider<AuthAPI>(plugins: [MoyaLoggingPlugin()])

    static let shared = AuthDataSource()
    private init() {}

    func login(accountID: String, password: String) -> Single<TokenDTO> {
        return provider.rx.request(.login(accountID: accountID, password: password))
            .filterSuccessfulStatusCodes()
            .map(TokenDTO.self)
            .catch { .error($0.toError(AuthError.self)) }
    }

    func signup(accountID: String, password: String, name: String, age: Int) -> Single<Response> {
        return provider.rx.request(.signup(accountID: accountID, password: password, name: name, age: age))
            .filterSuccessfulStatusCodes()
    }
}
