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

    public let addressViewModel: AddressViewModel
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

        // MARK: Address관련 UseCase
        let addressViewModel = AddressViewModel(
            fetchAddressUseCase: serviceDI.fetchAddressUseCase
        )

        return .init(
            homeViewModel: homeViewModel,
            loginViewModel: loginViewModel,
            signupViewModel: signupViewModel,
            mapViewModel: mapViewModel,
            postWriteViewModel: postWriteViewModel,
            postDetailViewModel: postDetailViewModel,
            addressViewModel: addressViewModel
        )
    }
}
