import Domain

public struct ServiceDI {
    public static let shared = resolve()

    public let loginUseCaseInject: LoginUseCase
    public let signupUseCaseInject: SignupUseCase

    public let fetchPopularityPostUseCase: FetchPopularityPostUseCase
    public let fetchPostDetailUseCase: FetchPostDetailUseCase
    public let createPostUseCase: CreatePostUseCase
    public let deletePostUseCase: DeletePostUseCase
    public let patchPostUseCase: PatchPostUseCase

    public let fetchAddressUseCase : FetchAddressUseCase
}

extension ServiceDI {
    private static func resolve() -> ServiceDI {
        let authRepo = AuthRepositoryImpl()
        let postRepo = PostRepositoryImpl()
        let addressRepo = AddressRepositoryImpl()

        // MARK: Auth관련 UseCase
        let loginUseCaseInject = LoginUseCase(repository: authRepo)
        let signupUseCaseInject = SignupUseCase(repository: authRepo)

        // MARK: Post관련 UseCase
        let fetchTotalPostUseCaseInject = FetchPopularityPostUseCase(repository: postRepo)
        let fetchPostDetailUseCaseInject = FetchPostDetailUseCase(repository: postRepo)
        let createPostUseCaseInject = CreatePostUseCase(repository: postRepo)
        let deletePostUseCase = DeletePostUseCase(repository: postRepo)
        let patchPostUseCase = PatchPostUseCase(repository: postRepo)

        // MARK: Address관련 UseCase
        let fetchAddressUseCaseInject = FetchAddressUseCase(repository: addressRepo)

        return .init(
            loginUseCaseInject: loginUseCaseInject,
            signupUseCaseInject: signupUseCaseInject,
            fetchPopularityPostUseCase: fetchTotalPostUseCaseInject,
            fetchPostDetailUseCase: fetchPostDetailUseCaseInject,
            createPostUseCase: createPostUseCaseInject,
            deletePostUseCase: deletePostUseCase,
            patchPostUseCase: patchPostUseCase,
            fetchAddressUseCase: fetchAddressUseCaseInject
//            postRegisterUseCase: postRegisterUseCaseInject,
//            postDeleteUseCase: postDeleteUseCaseInject,
//            postEditUseCase: postEditUseCaseInject
        )
    }
}
