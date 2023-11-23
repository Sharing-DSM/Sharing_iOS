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
    public let applicantViewModel: ApplicantViewModel

    public let chatViewModel: ChatViewModel
    public let chatRoomViewModel: ChatRoomViewModel

    public let addressViewModel: AddressViewModel
    
    public let profileViewModel: ProfileViewModel
    public let profileEditViewModel: ProfileEditViewModel
    public let setAreaOfInterestViewModel: SetAreaOfIntrestViewModel
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
            fetchPopularityPostUseCase: serviceDI.fetchPopularityPostUseCase,
            fetchAreaOfInterestUseCase: serviceDI.fetchAreaOfInterestPostUseCase,
            fetchEmergencyPostUseCase: serviceDI.fetchEmergencyPostUseCase
        )

        // MARK: Auth관련 viewModel
        let loginViewModel = LoginViewModel(
            loginUseCase: serviceDI.loginUseCase
        )
        let signupViewModel = SignupViewModel(
            signupUseCase: serviceDI.signupUseCase
        )
        let mapViewModel = MapViewModel(
            fetchSurroundingPostUseCase: serviceDI.fetchSurroundingPostUseCase,
            fetchPostDetailUseCase: serviceDI.fetchPostDetailUseCase,
            createChatRoomUseCase: serviceDI.createChatRoomUseCase
        )

        // MARK: Post관련 viewModel
        let postWriteViewModel = PostWriteViewModel(
            createPostUseCase: serviceDI.createPostUseCase
        )
        let postDetailViewModel = PostDetailViewModel(
            fetchPostDetailUseCase: serviceDI.fetchPostDetailUseCase,
            deletePostUseCase: serviceDI.deletePostUseCase,
            createChatRoomUseCase: serviceDI.createChatRoomUseCase,
            PostApplicationVolunteerUseCase: serviceDI.postApplicationVolunteerUseCase
        )
        let postEditViewModel = PostEditViewModel(
            fetchPostDetailUseCase: serviceDI.fetchPostDetailUseCase,
            patchPostUseCase: serviceDI.patchPostUseCase
        )
        let applicantViewModel = ApplicantViewModel(
            fetchApplicantListUseCase: serviceDI.fetchApplicantListUseCase
        )

        // MARK: Chat관련 viewModel
        let chatViewModel = ChatViewModel(
            fetchChatRoomListUseCase: serviceDI.fetchChatRoomListUseCase,
            chattingUseCase: serviceDI.chattingUseCase
        )
        let chatRoomViewModel = ChatRoomViewModel(
            chattingUseCase: serviceDI.chattingUseCase
        )

        // MARK: Address관련 viewModel
        let addressViewModel = AddressViewModel(
            fetchAddressUseCase: serviceDI.fetchAddressUseCase
        )

        //MARK: Profile관련 UseCase
        let profileViewModel = ProfileViewModel(
            fetchUserprofileUseCase: serviceDI.fetchUserProfileUseCase,
            uploadImageUseCase: serviceDI.uploadImageUseCase
        )
        let profileEditViewModel = ProfileEditViewModel(
            patchUserprofileUseCase: serviceDI.patchUserProfileUseCase,
            uploadImageUseCase: serviceDI.uploadImageUseCase
        )
        let myPostViewModel = MyPostViewModel(
            fetchMyPostUseCase: serviceDI.fetchMyPostUseCase
        )
        let applyHistoryViewModel = ApplyHistroyViewModel(
            fetchApplyHistoryUseCase: serviceDI.fetchApplyHistoryUseCase
        )
        let setAreaOfInterestViewModel = SetAreaOfIntrestViewModel(
            setAreaOfInterestUseCase: serviceDI.setAreaOfInterestUseCase
        )

        //MARK: Schedule관련 UseCase
        let scheduleViewModel = ScheduleViewModel(
            fetchCompleteScheduleUseCase: serviceDI.fetchCompleteSchedule,
            fetchUnCompleteScheduleUseCase: serviceDI.fetchUnCompleteSchedule,
            completeScheduleUseCase: serviceDI.completScheduleUseCase,
            deleteScheduleUseCase: serviceDI.deleteScheduleUseCase
        )
        let editScheduleViewModel = EditScheduleViewModel(
            editScheduleUseCase: serviceDI.patchScheduleUseCase
        )
        let creatScheduleViewModel = CreateSheduleViewModel(
            postScheduleUseCase: serviceDI.postSchedulesUseCase
        )
        

        return .init(
            homeViewModel: homeViewModel,
            loginViewModel: loginViewModel,
            signupViewModel: signupViewModel,
            mapViewModel: mapViewModel,
            postWriteViewModel: postWriteViewModel,
            postDetailViewModel: postDetailViewModel,
            postEditViewModel: postEditViewModel,
            applicantViewModel: applicantViewModel,
            chatViewModel: chatViewModel,
            chatRoomViewModel: chatRoomViewModel,
            addressViewModel: addressViewModel,
            profileViewModel: profileViewModel,
            profileEditViewModel: profileEditViewModel, 
            setAreaOfInterestViewModel: setAreaOfInterestViewModel,
            myPostViewModel: myPostViewModel,
            applyHistoryViewModel: applyHistoryViewModel,
            scheduleViewModel: scheduleViewModel,
            createScheduleViewModel: creatScheduleViewModel,
            editScheduleViewModel: editScheduleViewModel
        )
    }
}
