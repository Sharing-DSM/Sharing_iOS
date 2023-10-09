import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Core
import Domain

public class LoginViewModel: ViewModelType, Stepper {

    private let loginUseCase: LoginUseCase

    public var steps = PublishRelay<Step>()
    public var disposeBag: DisposeBag = DisposeBag()

    public init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }
    
    public struct Input {
        let signupButtonSignal: Observable<Void>
        let loginButtonSignal: Observable<Void>
        let idText: Observable<String>
        let passwordText: Observable<String>
    }

    public struct Output {
        let passwordErrorDescription: Signal<String?>
        let idErrorDescription: Signal<String?>
    }

    private let passwordErrorDescription = PublishRelay<String?>()
    private let idErrorDescription = PublishRelay<String?>()

    public func transform(input: Input) -> Output {
        let info = Observable.combineLatest(input.idText, input.passwordText)

        input.loginButtonSignal
            .withLatestFrom(info)
            .filter { self.checkLoginData($0.0, $0.1) }
            .flatMap { id, password in
                self.loginUseCase.execute(accountID: id, password: password)
                    .andThen(Single.just(SharingStep.tabsRequired))
                    .catch { .just(SharingStep.errorAlertRequired(content: $0.localizedDescription)) }
            }
            .bind(to: steps)
            .disposed(by: disposeBag)

        input.signupButtonSignal
            .map { SharingStep.signupRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output(
            passwordErrorDescription: passwordErrorDescription.asSignal(),
            idErrorDescription: idErrorDescription.asSignal()
        )
    }
}

extension LoginViewModel {
    private func checkLoginData(_ id: String, _ password: String) -> Bool {
        if id.isEmpty { idErrorDescription.accept("아이디를 입력해주세요") }
        else if !id.isCorrectID() { idErrorDescription.accept("올바르지 않은 형식의 아이디 입니다.") }
        else { idErrorDescription.accept(nil) }

        if password.isEmpty { passwordErrorDescription.accept("비밀번호를 입력해주세요") }
        else if !password.isCorrectPassword() { passwordErrorDescription.accept("올바르지 않은 형식의 비밀번호 입니다.") }
        else {passwordErrorDescription.accept(nil)}

        return !id.isEmpty && !password.isEmpty && id.isCorrectID() && password.isCorrectPassword()
    }
}
