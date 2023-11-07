import Foundation
import RxSwift
import Domain
import AppNetwork
import Core
import Moya

class AuthRepositoryImpl: AuthRepository {

    let authDataSource = AuthDataSource.shared
    private var disposeBag = DisposeBag()

    func login(accountID: String, password: String) -> Completable {

        return Completable.create { [weak self] completable in
            guard let self = self else { return Disposables.create {} }

            self.authDataSource.login(accountID: accountID, password: password)
                .subscribe(onSuccess: { tokenData in
                    TokenStorage.shared.accessToken = tokenData.accessToken
                    TokenStorage.shared.refreshToken = tokenData.refreshToken
                    completable(.completed)
                }, onFailure: {
                    completable(.error($0))
                })
                .disposed(by: self.disposeBag)

            return Disposables.create {}
        }
    }

    func signup(accountID: String, password: String, name: String, age: Int) -> Completable {
        return authDataSource.signup(accountID: accountID, password: password, name: name, age: age)
            .asCompletable()
    }
}
