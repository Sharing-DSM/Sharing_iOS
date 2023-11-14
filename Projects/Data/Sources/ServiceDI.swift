import Domain

public struct ServiceDI {
    public static let shared = resolve()

    public let loginUseCase: LoginUseCase
    public let signupUseCase: SignupUseCase


    public let fetchUserProfileUseCaseInject: FetchUserProfileUseCase
    public let patchUserProfileUseCaseInject: PatchUserProfileUseCase

    //schedules
    public let postSchedulesUseCaseInject: PostScheduleUseCase

    public let fetchPopularityPostUseCase: FetchPopularityPostUseCase
    public let fetchPostDetailUseCase: FetchPostDetailUseCase
    public let createPostUseCase: CreatePostUseCase
    public let deletePostUseCase: DeletePostUseCase
    public let patchPostUseCase: PatchPostUseCase
    public let fetchSurroundingPostUseCase: FetchSurroundingPostUseCase

    public let fetchAddressUseCase : FetchAddressUseCase

}

extension ServiceDI {
    private static func resolve() -> ServiceDI {
        let authRepo = AuthRepositoryImpl()

        let profileRepo = ProfileRepositoryImpl()

        let postRepo = PostRepositoryImpl()
        let addressRepo = AddressRepositoryImpl()

        // MARK: Auth관련 UseCase
        let loginUseCaseInject = LoginUseCase(repository: authRepo)
        let signupUseCaseInject = SignupUseCase(repository: authRepo)

        let fetchUserProfileUseCaseInject = FetchUserProfileUseCase(repository: profileRepo)
        let patchUserProfileUseCaseInject = PatchUserProfileUseCase(repository: profileRepo)

        let postSchedulesUseCaseInject = PostScheduleUseCase(repository: profileRepo)

        // MARK: Post관련 UseCase
        let fetchTotalPostUseCaseInject = FetchPopularityPostUseCase(repository: postRepo)
        let fetchPostDetailUseCaseInject = FetchPostDetailUseCase(repository: postRepo)
        let createPostUseCaseInject = CreatePostUseCase(repository: postRepo)
        let deletePostUseCaseInject = DeletePostUseCase(repository: postRepo)
        let patchPostUseCaseInject = PatchPostUseCase(repository: postRepo)
        let fetchSurroundingPostUseCaseInject = FetchSurroundingPostUseCase(repository: postRepo)

        // MARK: Address관련 UseCase
        let fetchAddressUseCaseInject = FetchAddressUseCase(repository: addressRepo)

        return .init(
            loginUseCase: loginUseCaseInject,
            signupUseCase: signupUseCaseInject,
            fetchUserProfileUseCaseInject: fetchUserProfileUseCaseInject,
            patchUserProfileUseCaseInject: patchUserProfileUseCaseInject,
            postSchedulesUseCaseInject: postSchedulesUseCaseInject,
            fetchPopularityPostUseCase: fetchTotalPostUseCaseInject,
            fetchPostDetailUseCase: fetchPostDetailUseCaseInject,
            createPostUseCase: createPostUseCaseInject,
            deletePostUseCase: deletePostUseCaseInject,
            patchPostUseCase: patchPostUseCaseInject,
            fetchSurroundingPostUseCase: fetchSurroundingPostUseCaseInject,
            fetchAddressUseCase: fetchAddressUseCaseInject
        )
    }
}
