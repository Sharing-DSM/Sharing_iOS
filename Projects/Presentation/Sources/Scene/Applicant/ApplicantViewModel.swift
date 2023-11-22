import RxSwift
import RxCocoa
import RxFlow
import Core
import Domain

public class ApplicantViewModel: ViewModelType, Stepper {

    public var steps = PublishRelay<Step>()
    public var disposeBag = DisposeBag()

    private let fetchApplicantListUseCase: FetchApplicantListUseCase

    public init(fetchApplicantListUseCase: FetchApplicantListUseCase) {
        self.fetchApplicantListUseCase = fetchApplicantListUseCase
    }

    private let applicantListData = BehaviorRelay<ApplicantListEntity>(value: [])

    public struct Input {
        let fetchApplicantList: Observable<String>
    }
    
    public struct Output {
        let applicantListData: Driver<ApplicantListEntity>
    }
    
    public func transform(input: Input) -> Output {

        input.fetchApplicantList
            .flatMap {
                self.fetchApplicantListUseCase.execute(id: $0)
                    .catch {
                        print($0)
                        return .never()
                    }
            }
            .bind(to: applicantListData)
            .disposed(by: disposeBag)
        
        return Output(
            applicantListData: applicantListData.asDriver()
        )
    }
}
