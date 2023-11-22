import Domain

public struct ServiceDI {
    public static let shared = resolve()

    // Auth
    public let loginUseCase: LoginUseCase
    public let signupUseCase: SignupUseCase

    // Post
    public let fetchPopularityPostUseCase: FetchPopularityPostUseCase
    public let fetchPostDetailUseCase: FetchPostDetailUseCase
    public let createPostUseCase: CreatePostUseCase
    public let deletePostUseCase: DeletePostUseCase
    public let patchPostUseCase: PatchPostUseCase
    public let fetchSurroundingPostUseCase: FetchSurroundingPostUseCase
    public let fetchEmergencyPostUseCase: FetchEmergencyPostUseCase
    public let fetchApplicantListUseCase: FetchApplicantListUseCase

    //Chat
    public let fetchChatRoomListUseCase: FetchChatRoomListUseCase
    public let createChatRoomUseCase: CreateChatRoomUseCase
    public let chattingUseCase: ChattingUseCase

    // Address
    public let fetchAddressUseCase: FetchAddressUseCase

    //userProfile
    public let fetchUserProfileUseCase: FetchUserProfileUseCase
    public let patchUserProfileUseCase: PatchUserProfileUseCase
    public let fetchMyPostUseCase: FetchMyPostUseCase
    public let fetchApplyHistoryUseCase: FetchApplyHistoryUseCase
    
    //schedules
    public let postSchedulesUseCase: PostScheduleUseCase
    public let fetchCompleteSchedule: FetchCompletScheduleUseCase
    public let fetchUnCompleteSchedule: FetchUnCompleteScheduleUseCase
    public let completScheduleUseCase: CompleteScheduleUseCase
    public let patchScheduleUseCase: PatchScheduleUseCase
    public let deleteScheduleUseCase: DeleteScheduleUseCase
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
        let fetchEmergencyPostUseCaseInject = FetchEmergencyPostUseCase(repository: postRepo)
        let fetchApplicantListUseCaseInject = FetchApplicantListUseCase(repository: postRepo)

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
            loginUseCase: loginUseCaseInject,
            signupUseCase: signupUseCaseInject,
            fetchPopularityPostUseCase: fetchTotalPostUseCaseInject,
            fetchPostDetailUseCase: fetchPostDetailUseCaseInject,
            createPostUseCase: createPostUseCaseInject,
            deletePostUseCase: deletePostUseCaseInject,
            patchPostUseCase: patchPostUseCaseInject,
            fetchSurroundingPostUseCase: fetchSurroundingPostUseCaseInject,
            fetchEmergencyPostUseCase: fetchEmergencyPostUseCaseInject,
            fetchApplicantListUseCase: fetchApplicantListUseCaseInject,
            fetchChatRoomListUseCase: fetchChatRoomListUseCaseInject,
            createChatRoomUseCase: createChatRoomUseCaseInject,
            chattingUseCase: chattingUseCaseInject,
            fetchAddressUseCase: fetchAddressUseCaseInject,
            fetchUserProfileUseCase: fetchUserProfileUseCaseInject,
            patchUserProfileUseCase: patchUserProfileUseCaseInject,
            fetchMyPostUseCase: fetchMyPostUseCaseInject,
            fetchApplyHistoryUseCase: fetchMyApplyHistoryUseCaseInject,
            postSchedulesUseCase: postSchedulesUseCaseInject,
            fetchCompleteSchedule: fetchCompleteScheduleUseCaseInject,
            fetchUnCompleteSchedule: fetchUnCompleteScheduleUseCaseInject,
            completScheduleUseCase: completeScheduleUsecaseInject,
            patchScheduleUseCase: patchScheduleUseCaseInject,
            deleteScheduleUseCase: deleteScheduleUseCaseInject
        )
    }
}
