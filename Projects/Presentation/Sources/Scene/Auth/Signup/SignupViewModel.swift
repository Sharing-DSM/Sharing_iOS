import Foundation
import RxSwift
import RxFlow
import RxCocoa
import Domain
import Core

public class SignupViewModel: ViewModelType, Stepper {
    public var steps = PublishRelay<Step>()

    public var disposeBag: DisposeBag = DisposeBag()

    private let signupUseCase: SignupUseCase

    public init(signupUseCase: SignupUseCase) {
        self.signupUseCase = signupUseCase
    }
    
    public struct Input {
        let idText: Observable<String>
        let passwordText: Observable<String>
        let nameText: Observable<String>
        let ageText: Observable<String>
        let signupButtonSignal: Observable<Void>
    }

    public struct Output {
        let idErrorDescription: Signal<String?>
        let passwordErrorDescription: Signal<String?>
        let nameErrorDescription: Signal<String?>
        let ageErrorDescription: Signal<String?>
    }

    private let idErrorDescription = PublishRelay<String?>()
    private let passwordErrorDescription = PublishRelay<String?>()
    private let nameErrorDescription = PublishRelay<String?>()
    private let ageErrorDescription = PublishRelay<String?>()

    public func transform(input: Input) -> Output {
        let info = Observable.combineLatest(input.idText, input.passwordText, input.nameText, input.ageText)

        input.signupButtonSignal.asObservable()
            .withLatestFrom(info)
            .filter { id, password, name, age in
                self.idErrorDescription.accept(id.isEmpty ? "아이디를 입력해주세요" : nil)
                self.passwordErrorDescription.accept(password.isEmpty ? "비밀번호를 입력해주세요" : nil)
                self.nameErrorDescription.accept(name.isEmpty ? "이름을 입력해주세요" : nil)
                self.ageErrorDescription.accept(age.isEmpty ? "나이를 입력해주세요" : nil)
                return !id.isEmpty && !password.isEmpty && !name.isEmpty && !age.isEmpty
            }
            .flatMap { id, password, name, age in
                self.signupUseCase.execute(accountID: id, password: password, name: name, age: Int(age) ?? 0)
                    .andThen(Single.just(SharingStep.alertRequired(title: "회원가입 성공", content: "같은 아이디와 비밀번호로 로그인을 시도해주세요.")))
                    .catch { .just(SharingStep.errorAlertRequired(content: $0.localizedDescription)) }
            }
            .bind(to: steps)
            .disposed(by: disposeBag)
        
        return Output(
            idErrorDescription: idErrorDescription.asSignal(),
            passwordErrorDescription: passwordErrorDescription.asSignal(),
            nameErrorDescription: nameErrorDescription.asSignal(),
            ageErrorDescription: ageErrorDescription.asSignal()
        )
    }
}
