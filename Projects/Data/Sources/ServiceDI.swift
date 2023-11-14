import Domain

public struct ServiceDI {
    public static let shared = resolve()

    public let loginUseCase: LoginUseCase
    public let signupUseCase: SignupUseCase

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
        let postRepo = PostRepositoryImpl()
        let addressRepo = AddressRepositoryImpl()

        // MARK: Auth관련 UseCase
        let loginUseCaseInject = LoginUseCase(repository: authRepo)
        let signupUseCaseInject = SignupUseCase(repository: authRepo)

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
            fetchPopularityPostUseCase: fetchTotalPostUseCaseInject,
            fetchPostDetailUseCase: fetchPostDetailUseCaseInject,
            createPostUseCase: createPostUseCaseInject,
            deletePostUseCase: deletePostUseCaseInject,
            patchPostUseCase: patchPostUseCaseInject,
            fetchSurroundingPostUseCase: fetchSurroundingPostUseCaseInject,
            fetchAddressUseCase: fetchAddressUseCaseInject
//            postRegisterUseCase: postRegisterUseCaseInject,
//            postDeleteUseCase: postDeleteUseCaseInject,
//            postEditUseCase: postEditUseCaseInject
        )
    }
}
