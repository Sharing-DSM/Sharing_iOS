import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Domain
import Core

public class ProfileEditViewModel: ViewModelType, Stepper {
    
    public var steps = PublishRelay<Step>()
    public var disposeBag = DisposeBag()

    private let patchUserprofileUseCase: PatchUserProfileUseCase

    public init(patchUserprofileUseCase: PatchUserProfileUseCase) {
        self.patchUserprofileUseCase = patchUserprofileUseCase
    }

    public struct Input {
        let editButtonSignal: Observable<Void>
        let idText: Observable<String>
        let nameText: Observable<String>
        let ageText: Observable<Int>
    }
    public struct Output {
    }

    public func transform(input: Input) -> Output {
        let info = Observable.combineLatest(input.idText, input.nameText, input.ageText)

        input.editButtonSignal
            .withLatestFrom(info)
            .flatMap { id, name, age in
                self.patchUserprofileUseCase.excute(name: name, id: id, age: age)
            }
            .map { _ in SharingStep.tabsRequired}
            .bind(to: steps)
            .disposed(by: disposeBag)
        return Output()
    }
}
