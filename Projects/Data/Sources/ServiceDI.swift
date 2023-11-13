import Domain

public struct ServiceDI {
    public static let shared = resolve()

    public let loginUseCaseInject: LoginUseCase
    public let signupUseCaseInject: SignupUseCase

    public let fetchUserProfileUseCaseInject: FetchUserProfileUseCase
    public let patchUserProfileUseCaseInject: PatchUserProfileUseCase

    //schedules
    public let postSchedulesUseCaseInject: PostScheduleUseCase
}

extension ServiceDI {
    private static func resolve() -> ServiceDI {
        let authRepo = AuthRepositoryImpl()
        let profileRepo = ProfileRepositoryImpl()

        // MARK: Auth관련 UseCase
        let loginUseCaseInject = LoginUseCase(repository: authRepo)
        let signupUseCaseInject = SignupUseCase(repository: authRepo)

        let fetchUserProfileUseCaseInject = FetchUserProfileUseCase(repository: profileRepo)
        let patchUserProfileUseCaseInject = PatchUserProfileUseCase(repository: profileRepo)

        let postSchedulesUseCaseInject = PostScheduleUseCase(repository: profileRepo)

        return .init(
            loginUseCaseInject: loginUseCaseInject,
            signupUseCaseInject: signupUseCaseInject,
            fetchUserProfileUseCaseInject: fetchUserProfileUseCaseInject,
            patchUserProfileUseCaseInject: patchUserProfileUseCaseInject,
            postSchedulesUseCaseInject: postSchedulesUseCaseInject
        )
    }
}
