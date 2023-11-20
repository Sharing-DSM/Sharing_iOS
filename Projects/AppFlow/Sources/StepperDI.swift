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
    public let createScheduleViewModel: CreateSheduleViewModel
}

extension StepperDI {
    private static func resolve() -> StepperDI {

        let serviceDI = ServiceDI.shared

        // MARK: Home관련 viewModel
        let homeViewModel = HomeViewModel(
            fetchPopularityPostUseCase: serviceDI.fetchPopularityPostUseCase
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
            createChatRoomUseCase: serviceDI.createChatRoomUseCase
        )
        let postEditViewModel = PostEditViewModel(
            fetchPostDetailUseCase: serviceDI.fetchPostDetailUseCase,
            patchPostUseCase: serviceDI.patchPostUseCase
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

        let profileViewModel = ProfileViewModel(
            fetchUserprofileUseCase: serviceDI.fetchUserProfileUseCaseInject
        )
        let profileEditViewModel = ProfileEditViewModel(
            patchUserprofileUseCase: serviceDI.patchUserProfileUseCaseInject
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
            createScheduleViewModel: creatScheduleViewModel
        )
    }
}
