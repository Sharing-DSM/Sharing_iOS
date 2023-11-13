import Domain
import Data
import Presentation

public struct StepperDI {
    public static let shared = resolve()

    public let loginViewModel: LoginViewModel
    public let signupViewModel: SignupViewModel
    public let mapViewModel: MapViewModel
    public let profileViewModel: ProfileViewModel
    public let profileEditViewModel: ProfileEditViewModel
    public let createScheduleViewModel: CreateSheduleViewModel
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
        let mapViewModel = MapViewModel()

        let profileViewModel = ProfileViewModel(
            fetchUserprofileUseCase: ServiceDI.fetchUserProfileUseCaseInject
        )
        let profileEditViewModel = ProfileEditViewModel(
            patchUserprofileUseCase: ServiceDI.patchUserProfileUseCaseInject
        )

        let creatScheduleViewModel = CreateSheduleViewModel(
            postScheduleUseCase: ServiceDI.postSchedulesUseCaseInject
        )

        return .init(
            loginViewModel: loginViewModel,
            signupViewModel: signupViewModel,
            mapViewModel: mapViewModel,
            profileViewModel: profileViewModel,
            profileEditViewModel: profileEditViewModel,
            createScheduleViewModel: creatScheduleViewModel
        )
    }
}
