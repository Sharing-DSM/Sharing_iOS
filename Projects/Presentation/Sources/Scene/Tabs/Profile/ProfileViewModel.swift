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
        let viewWillApear: Observable<Void>
        let applyButtonDidTap: Observable<Void>
        let scheduleButtonDidTap: Observable<Void>
        let profileEditButtonDidTap: Observable<Void>
        let myPostButtonDidTap: Observable<Void>
        let logoutButtonDidTap: Observable<Void>
    }
    public struct Output {
        let userProfileData: Signal<UserProfileEntity>
    }

    public func transform(input: Input) -> Output {
        let userProfileData = PublishRelay<UserProfileEntity>()
        input.viewWillApear
            .flatMap {
                self.fetchUserprofileUseCase.excute()
            }
            .bind(to: userProfileData)
            .disposed(by: disposeBag)
        input.profileEditButtonDidTap
            .map { SharingStep.profileEditRequired}
            .bind(to: steps)
            .disposed(by: disposeBag)
        input.scheduleButtonDidTap
            .map{ SharingStep.scheduleRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)
        input.myPostButtonDidTap
            .map { SharingStep.myPostRequired}
            .bind(to: steps)
            .disposed(by: disposeBag)
        input.applyButtonDidTap
            .map { SharingStep.applyHistoryRequired}
            .bind(to: steps)
            .disposed(by: disposeBag)
        input.logoutButtonDidTap
            .map { SharingStep.loginRequired}
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output(userProfileData: userProfileData.asSignal())
    }
}
