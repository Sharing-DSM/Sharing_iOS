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

    //userProfile
    public let fetchUserProfileUseCaseInject: FetchUserProfileUseCase
    public let patchUserProfileUseCaseInject: PatchUserProfileUseCase
    public let fetchMyPostUseCaseInject: FetchMyPostUseCase
    public let fetchApplyHistoryUseCaseInject: FetchApplyHistoryUseCase
    
    //schedules
    public let postSchedulesUseCaseInject: PostScheduleUseCase
    public let fetchCompleteScheduleInject: FetchCompletScheduleUseCase
    public let fetchUnCompleteScheduleInject: FetchUnCompleteScheduleUseCase
    public let completScheduleUseCaseInject: CompleteScheduleUseCase
    public let patchScheduleUseCaseInject: PatchScheduleUseCase
    public let deleteScheduleUseCaseInject: DeleteScheduleUseCase
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

        // MARK: Post관련 UseCase
        let fetchTotalPostUseCaseInject = FetchPopularityPostUseCase(repository: postRepo)
        let fetchPostDetailUseCaseInject = FetchPostDetailUseCase(repository: postRepo)
        let createPostUseCaseInject = CreatePostUseCase(repository: postRepo)
        let deletePostUseCaseInject = DeletePostUseCase(repository: postRepo)
        let patchPostUseCaseInject = PatchPostUseCase(repository: postRepo)
        let fetchSurroundingPostUseCaseInject = FetchSurroundingPostUseCase(repository: postRepo)

        // MARK: Address관련 UseCase
        let fetchAddressUseCaseInject = FetchAddressUseCase(repository: addressRepo)

        // MARK: UserProfile관련 UseCase
        let fetchUserProfileUseCaseInject = FetchUserProfileUseCase(repository: profileRepo)
        let patchUserProfileUseCaseInject = PatchUserProfileUseCase(repository: profileRepo)
        let fetchMyPostUseCaseInject = FetchMyPostUseCase(repository: profileRepo)
        let fetchMyApplyHistoryUseCaseInject = FetchApplyHistoryUseCase(repository: profileRepo)

        // MARK: Schedule관련 UseCase
        let postSchedulesUseCaseInject = PostScheduleUseCase(repository: profileRepo)
        let fetchCompleteScheduleUseCaseInject = FetchCompletScheduleUseCase(repository: profileRepo)
        let fetchUnCompleteScheduleUseCaseInject = FetchUnCompleteScheduleUseCase(repository: profileRepo)
        let completeScheduleUsecaseInject = CompleteScheduleUseCase(repository: profileRepo)
        let patchScheduleUseCaseInject = PatchScheduleUseCase(repository: profileRepo)
        let deleteScheduleUseCaseInject = DeleteScheduleUseCase(repository: profileRepo)
        

        return .init(

            loginUseCaseInject: loginUseCaseInject,
            signupUseCaseInject: signupUseCaseInject,
            fetchPopularityPostUseCase: fetchTotalPostUseCaseInject,
            fetchPostDetailUseCase: fetchPostDetailUseCaseInject,
            createPostUseCase: createPostUseCaseInject,
            deletePostUseCase: deletePostUseCase,
            patchPostUseCase: patchPostUseCase,
            fetchAddressUseCase: fetchAddressUseCaseInject,
            fetchUserProfileUseCaseInject: fetchUserProfileUseCaseInject,
            patchUserProfileUseCaseInject: patchUserProfileUseCaseInject,
            fetchMyPostUseCaseInject: fetchMyPostUseCaseInject,
            fetchApplyHistoryUseCaseInject: fetchMyApplyHistoryUseCaseInject,
            postSchedulesUseCaseInject: postSchedulesUseCaseInject,
            fetchCompleteScheduleInject: fetchCompleteScheduleUseCaseInject, 
            fetchUnCompleteScheduleInject: fetchUnCompleteScheduleUseCaseInject,
            completScheduleUseCaseInject: completeScheduleUsecaseInject,
            patchScheduleUseCaseInject: patchScheduleUseCaseInject,
            deleteScheduleUseCaseInject: deleteScheduleUseCaseInject
//            postRegisterUseCase: postRegisterUseCaseInject,
//            postDeleteUseCase: postDeleteUseCaseInject,
//            postEditUseCase: postEditUseCaseInject

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
