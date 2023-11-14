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
    
    public let addressViewModel: AddressViewModel
    
    public let profileViewModel: ProfileViewModel
    public let profileEditViewModel: ProfileEditViewModel
    public let createScheduleViewModel: CreateSheduleViewModel
}

extension StepperDI {
    private static func resolve() -> StepperDI {

        let serviceDI = ServiceDI.shared

        // MARK: Home관련 UseCase
        let homeViewModel = HomeViewModel(
            fetchPopularityPostUseCase: serviceDI.fetchPopularityPostUseCase
        )

        // MARK: Auth관련 UseCase
        let loginViewModel = LoginViewModel(
            loginUseCase: serviceDI.loginUseCase
        )
        let signupViewModel = SignupViewModel(
            signupUseCase: serviceDI.signupUseCase
        )
        let mapViewModel = MapViewModel(
            fetchSurroundingPostUseCase: serviceDI.fetchSurroundingPostUseCase,
            fetchPostDetailUseCase: serviceDI.fetchPostDetailUseCase
        )

        // MARK: Post관련 UseCase
        let postWriteViewModel = PostWriteViewModel(
            createPostUseCase: serviceDI.createPostUseCase
        )
        let postDetailViewModel = PostDetailViewModel(
            fetchPostDetailUseCase: serviceDI.fetchPostDetailUseCase,
            deletePostUseCase: serviceDI.deletePostUseCase
        )
        let postEditViewModel = PostEditViewModel(
            fetchPostDetailUseCase: serviceDI.fetchPostDetailUseCase,
            patchPostUseCase: serviceDI.patchPostUseCase
        )

        // MARK: Address관련 UseCase
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
            addressViewModel: addressViewModel,
            profileViewModel: profileViewModel,
            profileEditViewModel: profileEditViewModel,
            createScheduleViewModel: creatScheduleViewModel
        )
    }
}
