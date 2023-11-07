import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Domain
import Core

public class PostWriteViewModel: ViewModelType, Stepper {
    public var steps = PublishRelay<Step>()
    public var disposeBag = DisposeBag()

    private let createPostUseCase: CreatePostUseCase
    
    public init(createPostUseCase: CreatePostUseCase) {
        self.createPostUseCase = createPostUseCase
    }
    
    public struct Input {
        let titleText: Observable<String>
        let addressData: Observable<AddressEntityElement?>
        let recruitmentText: Observable<String>
        let tagData: Observable<TagTypeEnum>
        let volunteerTimeText: Observable<String>
        let detailContentText: Observable<String>
        let isEmergency: Observable<Bool>
        let completeButtonDidClick: Observable<Void>
    }

    public struct Output {
        let isCompleteButtonEnable: Signal<Bool>
    }
    
    public func transform(input: Input) -> Output {
        let info = Observable.combineLatest(
            input.titleText,
            input.addressData,
            input.recruitmentText,
            input.tagData,
            input.volunteerTimeText,
            input.detailContentText,
            input.isEmergency
        )
        let isCompleteButtonEnable = info.map { title, address, recruitment, tag, volunteerTime, detailContent, _ -> Bool in
            address != nil && tag != .NONE && !title.isEmpty && !recruitment.isEmpty && !volunteerTime.isEmpty && !detailContent.isEmpty
        }

        input.completeButtonDidClick.withLatestFrom(info)
            .flatMap { title, address, recruitment, tag, volunteerTime, detailContent, isEmergency -> Single<SharingStep> in
                guard let address = address,
                      let recruitment = Int(recruitment),
                      let volunteerTime = Int(volunteerTime)
                else { return .just(SharingStep.errorAlertRequired(content: "올바르지 않은 타입")) }
                return self.createPostUseCase.execute(
                    title: title,
                    content: detailContent,
                    addressData: address,
                    recruitment: recruitment,
                    type: tag.toString,
                    volunteerTime: volunteerTime,
                    isEmergency: isEmergency
                )
                .andThen(.just(SharingStep.succeedCreatePostRequired))
                .catch {
                    print($0.localizedDescription)
                    return .just(SharingStep.errorAlertRequired(content: $0.localizedDescription))
                }
            }
            .subscribe(onNext: { [weak self] step in
                self?.steps.accept(step)
            })
            .disposed(by: disposeBag)

        return Output(isCompleteButtonEnable: isCompleteButtonEnable.asSignal(onErrorJustReturn: false))
    }
}
