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
    private let uploadImageUseCase: UploadImageUseCase

    public init(
        patchUserprofileUseCase: PatchUserProfileUseCase,
        uploadImageUseCase: UploadImageUseCase
    ) {
        self.patchUserprofileUseCase = patchUserprofileUseCase
        self.uploadImageUseCase = uploadImageUseCase
    }

    public struct Input {
        let editCompleteButtonSignal: Observable<Void>
        let idText: Observable<String>
        let nameText: Observable<String>
        let ageText: Observable<Int>
        let profileChangeButtonDidTap: Observable<Data>
    }
    public struct Output {
        let nameErrorDescription: Signal<String?>
        let idErrorDescription: Signal<String?>
        let ageErrorDescription: Signal<String?>
    }

    let nameErrorDescription = PublishRelay<String?>()
    let idErrorDescription = PublishRelay<String?>()
    let ageErrorDescription = PublishRelay<String?>()

    public func transform(input: Input) -> Output {
        let info = Observable.combineLatest(input.idText, input.nameText, input.ageText)
        let imageUrl = PublishRelay<UploadImageResponseEntity>()

        input.editCompleteButtonSignal
            .withLatestFrom(info)
            .filter { self.checkData($0.0, $0.1, $0.2)}
            .flatMap { id, name, age in
                self.patchUserprofileUseCase.excute(name: name, id: id, age: age)
                    .andThen(Single.just(SharingStep.popRequired))
                    .catch { .just(SharingStep.errorAlertRequired(content: $0.localizedDescription)) }
            }
            .bind(to: steps)
            .disposed(by: disposeBag)
        input.profileChangeButtonDidTap
            .flatMap { imageData in
                self.uploadImageUseCase.excute(imageData: imageData)
            }
            .bind(to: imageUrl)
            .disposed(by: disposeBag)
        return Output(
            nameErrorDescription: nameErrorDescription.asSignal(),
            idErrorDescription: idErrorDescription.asSignal(),
            ageErrorDescription: ageErrorDescription.asSignal()
        )
    }
    private func checkData(_ id: String, _ name: String, _ age: Int) -> Bool {
        if id.isEmpty { idErrorDescription.accept("아이디를 입력해주세요") }
        else if !id.isCorrectID() { idErrorDescription.accept("올바르지 않은 형식의 아이디 입니다.") }
        else { idErrorDescription.accept(nil) }
        
        if name.isEmpty { nameErrorDescription.accept("이름을 입력해주세요") }
        else if !name.isCorrectName() { nameErrorDescription.accept("이름을 제대로 입력해주세요")}
        else { nameErrorDescription.accept(nil)}
        
        if age <= 10 { ageErrorDescription.accept("나이를 제대로 입력해주세요")}
        else { ageErrorDescription.accept(nil)}

        return !id.isEmpty && id.isCorrectID() && name.isCorrectName() && !name.isEmpty && !age.words.isEmpty && age.description.isCorrectAge()
    }
}
