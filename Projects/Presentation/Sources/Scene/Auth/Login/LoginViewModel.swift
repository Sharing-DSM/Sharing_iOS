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
        let passwordError: Signal<String?>
        let idErrorDescription: Signal<String?>
    }

    private let passwordError = PublishRelay<String?>()
    private let idErrorDescription = PublishRelay<String?>()

    public func transform(input: Input) -> Output {
        let info = Observable.combineLatest(input.idText, input.passwordText)

        input.loginButtonSignal
            .withLatestFrom(info)
            .filter {
                self.idErrorDescription.accept($0.0.isEmpty ? "아이디를 입력해주세요" : nil)
                self.passwordError.accept($0.1.isEmpty ? "비밀번호를 입력해주세요" : nil)
                return !$0.0.isEmpty && !$0.1.isEmpty
            }
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
            passwordError: passwordError.asSignal(),
            idErrorDescription: idErrorDescription.asSignal()
        )
    }
}
