import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Domain
import Core

public class ProfileViewModel: ViewModelType, Stepper {

    public var steps = PublishRelay<Step>()
    
    public var disposeBag = DisposeBag()

    private let fetchUserprofileUseCase: FetchUserProfileUseCase

    public init(fetchUserprofileUseCase: FetchUserProfileUseCase) {
        self.fetchUserprofileUseCase = fetchUserprofileUseCase
    }

    public struct Input {
        let viewDidLoad: Observable<Void>
    }
    public struct Output {
        let userProfileData: Signal<UserProfileEntity>
    }

    public func transform(input: Input) -> Output {
        let userProfileData = PublishRelay<UserProfileEntity>()
        input.viewDidLoad.asObservable()
            .flatMap {
                self.fetchUserprofileUseCase.excute()
            }
            .bind(to: userProfileData)
            .disposed(by: disposeBag)

        return Output(userProfileData: userProfileData.asSignal())
    }
}
