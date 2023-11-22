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

        // MARK: Home관련 UseCase
        let homeViewModel = HomeViewModel(
            fetchPopularityPostUseCase: serviceDI.fetchPopularityPostUseCase,
            fetchAreaOfInterestUseCase: serviceDI.fetchAreaOfInterestPostUseCase
        )

        // MARK: Auth관련 UseCase
        let loginViewModel = LoginViewModel(
            loginUseCase: serviceDI.loginUseCaseInject
        )
        let signupViewModel = SignupViewModel(
            signupUseCase: serviceDI.signupUseCaseInject
        )
        let mapViewModel = MapViewModel(
            fetchTotalPostUseCase: serviceDI.fetchPopularityPostUseCase
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

        //MARK: Profile관련 UseCase
        let profileViewModel = ProfileViewModel(
            fetchUserprofileUseCase: serviceDI.fetchUserProfileUseCaseInject,
            uploadImageUseCase: serviceDI.uploadImageUseCaseInject
        )
        let profileEditViewModel = ProfileEditViewModel(
            patchUserprofileUseCase: serviceDI.patchUserProfileUseCaseInject,
            uploadImageUseCase: serviceDI.uploadImageUseCaseInject
        )
        let myPostViewModel = MyPostViewModel(
            fetchMyPostUseCase: serviceDI.fetchMyPostUseCaseInject
        )
        let applyHistoryViewModel = ApplyHistroyViewModel(
            fetchApplyHistoryUseCase: serviceDI.fetchApplyHistoryUseCaseInject
        )
        let setAreaOfInterestViewModel = SetAreaOfIntrestViewModel(
            setAreaOfInterestUseCase: serviceDI.setAreaOfInterestUseCaseInject
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
