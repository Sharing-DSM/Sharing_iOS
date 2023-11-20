import Domain
import Data
import Presentation

public struct StepperDI {
    public static let shared = resolve()

    public let homeViewModel: HomeViewModel
    
    public let loginViewModel: LoginViewModel
    public let signupViewModel: SignupViewModel
    public let mapViewModel: MapViewModel
    
    public let postWriteViewModel: PostWriteViewModel
    public let postDetailViewModel: PostDetailViewModel
    public let postEditViewModel: PostEditViewModel

    public let chatViewModel: ChatViewModel
    public let chatRoomViewModel: ChatRoomViewModel

    public let addressViewModel: AddressViewModel
    
    public let profileViewModel: ProfileViewModel
    public let profileEditViewModel: ProfileEditViewModel
    public let myPostViewModel: MyPostViewModel
    public let applyHistoryViewModel: ApplyHistroyViewModel

    public let scheduleViewModel: ScheduleViewModel
    public let createScheduleViewModel: CreateSheduleViewModel
    public let editScheduleViewModel: EditScheduleViewModel
}

extension StepperDI {
    private static func resolve() -> StepperDI {

        let serviceDI = ServiceDI.shared

        // MARK: Home관련 viewModel
        let homeViewModel = HomeViewModel(
            fetchPopularityPostUseCase: serviceDI.fetchPopularityPostUseCaseInject
        )

        // MARK: Auth관련 viewModel
        let loginViewModel = LoginViewModel(
            loginUseCase: serviceDI.loginUseCaseInject
        )
        let signupViewModel = SignupViewModel(
            signupUseCase: serviceDI.signupUseCaseInject
        )
        let mapViewModel = MapViewModel(
            fetchSurroundingPostUseCase: serviceDI.fetchSurroundingPostUseCaseInject,
            fetchPostDetailUseCase: serviceDI.fetchPostDetailUseCaseInject,
            createChatRoomUseCase: serviceDI.createChatRoomUseCaseInject
        )

        // MARK: Post관련 viewModel
        let postWriteViewModel = PostWriteViewModel(
            createPostUseCase: serviceDI.createPostUseCaseInject
        )
        let postDetailViewModel = PostDetailViewModel(
            fetchPostDetailUseCase: serviceDI.fetchPostDetailUseCaseInject,
            deletePostUseCase: serviceDI.deletePostUseCaseInject,
            createChatRoomUseCase: serviceDI.createChatRoomUseCaseInject
        )
        let postEditViewModel = PostEditViewModel(
            fetchPostDetailUseCase: serviceDI.fetchPostDetailUseCaseInject,
            patchPostUseCase: serviceDI.patchPostUseCaseInject
        )

        // MARK: Chat관련 viewModel
        let chatViewModel = ChatViewModel(
            fetchChatRoomListUseCase: serviceDI.fetchChatRoomListUseCaseInject,
            chattingUseCase: serviceDI.chattingUseCaseInject
        )
        let chatRoomViewModel = ChatRoomViewModel(
            chattingUseCase: serviceDI.chattingUseCaseInject
        )

        // MARK: Address관련 viewModel
        let addressViewModel = AddressViewModel(
            fetchAddressUseCase: serviceDI.fetchAddressUseCaseInject
        )

        //MARK: Profile관련 UseCase
        let profileViewModel = ProfileViewModel(
            fetchUserprofileUseCase: serviceDI.fetchUserProfileUseCaseInject
        )
        let profileEditViewModel = ProfileEditViewModel(
            patchUserprofileUseCase: serviceDI.patchUserProfileUseCaseInject
        )
        let myPostViewModel = MyPostViewModel(
            fetchMyPostUseCase: serviceDI.fetchMyPostUseCaseInject
        )
        let applyHistoryViewModel = ApplyHistroyViewModel(
            fetchApplyHistoryUseCase: serviceDI.fetchApplyHistoryUseCaseInject
        )

        //MARK: Schedule관련 UseCase
        let scheduleViewModel = ScheduleViewModel(
            fetchCompleteScheduleUseCase: serviceDI.fetchCompleteScheduleInject,
            fetchUnCompleteScheduleUseCase: serviceDI.fetchUnCompleteScheduleInject,
            completeScheduleUseCase: serviceDI.completScheduleUseCaseInject,
            deleteScheduleUseCase: serviceDI.deleteScheduleUseCaseInject
        )
        let editScheduleViewModel = EditScheduleViewModel(
            editScheduleUseCase: serviceDI.patchScheduleUseCaseInject
        )
        let creatScheduleViewModel = CreateSheduleViewModel(
            postScheduleUseCase: serviceDI.postSchedulesUseCaseInject
        )
        

        return .init(
            homeViewModel: homeViewModel,
            loginViewModel: loginViewModel,
            signupViewModel: signupViewModel,
            mapViewModel: mapViewModel,
            postWriteViewModel: postWriteViewModel,
            postDetailViewModel: postDetailViewModel,
            postEditViewModel: postEditViewModel,
            chatViewModel: chatViewModel,
            chatRoomViewModel: chatRoomViewModel,
            addressViewModel: addressViewModel,
            profileViewModel: profileViewModel,
            profileEditViewModel: profileEditViewModel,
            myPostViewModel: myPostViewModel,
            applyHistoryViewModel: applyHistoryViewModel,
            scheduleViewModel: scheduleViewModel,
            createScheduleViewModel: creatScheduleViewModel,
            editScheduleViewModel: editScheduleViewModel
        )
    }
}
