import Domain

public struct ServiceDI {
    public static let shared = resolve()

    // Auth
    public let loginUseCaseInject: LoginUseCase
    public let signupUseCaseInject: SignupUseCase

    // Post
    public let fetchPopularityPostUseCaseInject: FetchPopularityPostUseCase
    public let fetchPostDetailUseCaseInject: FetchPostDetailUseCase
    public let createPostUseCaseInject: CreatePostUseCase
    public let deletePostUseCaseInject: DeletePostUseCase
    public let patchPostUseCaseInject: PatchPostUseCase
    public let fetchSurroundingPostUseCaseInject: FetchSurroundingPostUseCase

    //Chat
    public let fetchChatRoomListUseCaseInject: FetchChatRoomListUseCase
    public let createChatRoomUseCaseInject: CreateChatRoomUseCase
    public let chattingUseCaseInject: ChattingUseCase

    // Address
    public let fetchAddressUseCaseInject: FetchAddressUseCase

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
        let chatRepo = ChatRepositoryImpl()
        let addressRepo = AddressRepositoryImpl()

        // MARK: Auth관련 UseCase
        let loginUseCaseInject = LoginUseCase(
            authRepository: authRepo,
            chatRepository: chatRepo
        )
        let signupUseCaseInject = SignupUseCase(repository: authRepo)

        // MARK: Post관련 UseCase
        let fetchTotalPostUseCaseInject = FetchPopularityPostUseCase(repository: postRepo)
        let fetchPostDetailUseCaseInject = FetchPostDetailUseCase(repository: postRepo)
        let createPostUseCaseInject = CreatePostUseCase(repository: postRepo)
        let deletePostUseCaseInject = DeletePostUseCase(repository: postRepo)
        let patchPostUseCaseInject = PatchPostUseCase(repository: postRepo)
        let fetchSurroundingPostUseCaseInject = FetchSurroundingPostUseCase(repository: postRepo)

        // MARK: Chat관련 UseCase
        let fetchChatRoomListUseCaseInject = FetchChatRoomListUseCase(repository: chatRepo)
        let createChatRoomUseCaseInject = CreateChatRoomUseCase(repository: chatRepo)
        let chattingUseCaseInject = ChattingUseCase(repository: chatRepo)

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
            fetchPopularityPostUseCaseInject: fetchTotalPostUseCaseInject,
            fetchPostDetailUseCaseInject: fetchPostDetailUseCaseInject,
            createPostUseCaseInject: createPostUseCaseInject,
            deletePostUseCaseInject: deletePostUseCaseInject,
            patchPostUseCaseInject: patchPostUseCaseInject,
            fetchSurroundingPostUseCaseInject: fetchSurroundingPostUseCaseInject,
            fetchChatRoomListUseCaseInject: fetchChatRoomListUseCaseInject,
            createChatRoomUseCaseInject: createChatRoomUseCaseInject,
            chattingUseCaseInject: chattingUseCaseInject,
            fetchAddressUseCaseInject: fetchAddressUseCaseInject,
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
        )
    }
}
