import Foundation
import RxSwift

public protocol AuthRepository {
    func login(accountID: String, password: String) -> Completable
    func signup(accountID: String, password: String, name: String, age: Int) -> Completable
}
