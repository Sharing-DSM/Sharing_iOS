import Foundation
import RxSwift

public class LoginUseCase {

    let disposeBag = DisposeBag()

    let authRepository: AuthRepository
    let chatRepository: ChatRepository

    public init(authRepository: AuthRepository, chatRepository: ChatRepository) {
        self.authRepository = authRepository
        self.chatRepository = chatRepository
    }

    public func login(accountID: String, password: String) -> Completable {
        return Completable.create { [weak self] completable in
            guard let self = self else { return Disposables.create {} }
            authRepository.login(accountID: accountID, password: password)
                .subscribe(
                    with: self,
                    onCompleted: { owner in
                        owner.connectSocket()
                        completable(.completed)
                    },
                    onError: { owner, err in
                        completable(.error(err))
                    }
                )
                .disposed(by: disposeBag)
            return Disposables.create {}
        }
    }

    public func connectSocket() {
        chatRepository.connectSocket()
    }
}
