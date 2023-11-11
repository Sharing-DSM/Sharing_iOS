import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Domain
import Core

public class PostEditViewModel: ViewModelType, Stepper {

    public var steps = PublishRelay<Step>()
    public var disposeBag = DisposeBag()

    private let fetchPostDetailUseCase: FetchPostDetailUseCase
    private let patchPostUseCase: PatchPostUseCase

    public init(
        fetchPostDetailUseCase: FetchPostDetailUseCase,
        patchPostUseCase: PatchPostUseCase
    ) {
        self.fetchPostDetailUseCase = fetchPostDetailUseCase
        self.patchPostUseCase = patchPostUseCase
    }

    private let detailData = PublishRelay<PostDetailEntity>()

    private var title = PublishRelay<String>()
    private var recruitment = PublishRelay<String>()
    private var volunteerTime = PublishRelay<String>()
    private var detailContent = PublishRelay<String>()

    public struct Input {
        let titleText: Observable<String>
        let addressData: Observable<AddressEntityElement?>
        let recruitmentText: Observable<String>
        let tagData: Observable<TagTypeEnum>
        let volunteerTimeText: Observable<String>
        let detailContentText: Observable<String>
        let isEmergency: Observable<Bool>
        let fetchPostDetail: Observable<String>
        let patchPost: Observable<String>
    }

    public struct Output {
        let isCompleteButtonEnable: Signal<Bool>
        let detailData: Signal<PostDetailEntity>
    }
    
    public func transform(input: Input) -> Output {
        let info = Observable.combineLatest(
            input.patchPost,
            title,
            input.addressData,
            recruitment,
            input.tagData,
            volunteerTime,
            detailContent,
            input.isEmergency
        )

        let isCompleteButtonEnable = info.map { _, title, address, recruitment, tag, volunteerTime, detailContent, _ -> Bool in
            address != nil && tag != .none && !title.isEmpty && !recruitment.isEmpty && !volunteerTime.isEmpty && !detailContent.isEmpty
        }

        input.titleText
            .bind(to: title)
            .disposed(by: disposeBag)

        input.recruitmentText
            .bind(to: recruitment)
            .disposed(by: disposeBag)

        input.volunteerTimeText
            .bind(to: volunteerTime)
            .disposed(by: disposeBag)

        input.detailContentText
            .bind(to: detailContent)
            .disposed(by: disposeBag)

        input.fetchPostDetail
            .flatMap {
                self.fetchPostDetailUseCase.excute(id: $0)
                    .catch {
                        print($0.localizedDescription)
                        return .never()
                    }
            }
            .subscribe(
                with: self,
                onNext: { owner, data in
                    owner.detailData.accept(data)
                    owner.title.accept(data.title)
                    owner.recruitment.accept("\(data.recruitment)")
                    owner.volunteerTime.accept("\(data.volunteerTime)")
                    owner.detailContent.accept(data.content)
                }
            )
            .disposed(by: disposeBag)

        input.patchPost.withLatestFrom(info)
            .flatMap { id, title, address, recruitment, tag, volunteerTime, detailContent, isEmergency -> Single<SharingStep> in
                guard let address = address,
                      let recruitment = Int(recruitment),
                      let volunteerTime = Int(volunteerTime)
                else { return .just(SharingStep.errorAlertRequired(content: "올바르지 않은 타입")) }
                return self.patchPostUseCase.execute(
                    id: id,
                    title: title,
                    content: detailContent,
                    addressName: address.addressName,
                    roadAddressName: address.roadAddressName,
                    xCos: address.x,
                    yCos: address.y,
                    recruitment: recruitment,
                    type: tag.rawValue,
                    volunteerTime: volunteerTime,
                    isEmergency: isEmergency
                )
                .andThen(.just(SharingStep.popRequired))
                .catch {
                    print($0.localizedDescription)
                    return .just(SharingStep.errorAlertRequired(content: $0.localizedDescription))
                }
            }
            .subscribe(
                with: self,
                onNext: { owner, step in
                    owner.steps.accept(step)
                }
            )
            .disposed(by: disposeBag)
            
        return Output(
            isCompleteButtonEnable: isCompleteButtonEnable.asSignal(onErrorJustReturn: false),
            detailData: detailData.asSignal()
        )
    }
}
