import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxFlow
import Domain
import Core

public class ProfileViewModel: ViewModelType, Stepper {

    public var steps = PublishRelay<Step>()
    
    public var disposeBag = DisposeBag()

    private let fetchUserprofileUseCase: FetchUserProfileUseCase
    private let uploadImageUseCase: UploadImageUseCase

    public init(
        fetchUserprofileUseCase: FetchUserProfileUseCase,
        uploadImageUseCase: UploadImageUseCase
    ) {
        self.fetchUserprofileUseCase = fetchUserprofileUseCase
        self.uploadImageUseCase = uploadImageUseCase
    }
    
    public struct Input {
        let viewWillApear: Observable<Void>
        let applyButtonDidTap: Observable<Void>
        let addressButtonDidTap: Observable<Void>
        let scheduleButtonDidTap: Observable<Void>
        let profileEditButtonDidTap: Observable<Void>
        let myPostButtonDidTap: Observable<Void>
        let logoutButtonDidTap: Observable<Void>
        let imageData: Observable<Data>
        let currentImage: UIImage
        let guideLineButtonDidTap: Observable<Void>
    }
    public struct Output {
        let userProfileData: Signal<UserProfileEntity>
        let imageUrl: Signal<UploadImageResponseEntity>
    }

    public func transform(input: Input) -> Output {
        let userProfileData = PublishRelay<UserProfileEntity>()
        let imageUrl = PublishRelay<UploadImageResponseEntity>()
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
        input.addressButtonDidTap
            .map { SharingStep.setAreaOfInterestRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)
        input.imageData
            .flatMap { data in
                self.uploadImageUseCase.excute(imageData: data)
            }
            .bind(to: imageUrl)
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
        input.guideLineButtonDidTap
            .map { SharingStep.guideLineRequired}
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output(userProfileData: userProfileData.asSignal(), imageUrl: imageUrl.asSignal())
    }
}
