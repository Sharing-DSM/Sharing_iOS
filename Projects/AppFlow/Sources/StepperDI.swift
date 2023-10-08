import Domain
import Data
import Presentation

public struct StepperDI {
    public static let shared = resolve()

    public let loginViewModel: LoginViewModel
    public let signupViewModel: SignupViewModel
}

extension StepperDI {
    private static func resolve() -> StepperDI {
        let ServiceDI = ServiceDI.shared

        // MARK: Auth관련 UseCase
        let loginViewModel = LoginViewModel(
            loginUseCase: ServiceDI.loginUseCaseInject
        )
        let signupViewModel = SignupViewModel(
            signupUseCase: ServiceDI.signupUseCaseInject
        )

        return .init(
            loginViewModel: loginViewModel,
            signupViewModel: signupViewModel
        )
    }
}
