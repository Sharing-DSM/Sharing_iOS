import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Core
import Domain

public class SearchViewModel: ViewModelType, Stepper {
    
    public var steps = PublishRelay<Step>()
    public var disposeBag = DisposeBag()
    
    private let searchInPostTitleUseCase: SearchInPostTitleUseCase
    
    public init(searchInPostTitleUseCase: SearchInPostTitleUseCase) {
        self.searchInPostTitleUseCase = searchInPostTitleUseCase
    }
    
    private let searchPostData = PublishRelay<CommonPostEntity>()
    
    public struct Input {
        let searchPost: Observable<String>
        let showDetail: Observable<String>
    }
    
    public struct Output {
        let searchPostData: Signal<CommonPostEntity>
    }
    
    public func transform(input: Input) -> Output {

        input.showDetail
            .map { SharingStep.postDetailRequired(id: $0) }
            .bind(to: steps)
            .disposed(by: disposeBag)

        input.searchPost
            .flatMap {
                self.searchInPostTitleUseCase.excute(keyword: $0)
                    .catch {
                        print($0.localizedDescription)
                        return .never()
                    }
            }
            .bind(to: searchPostData)
            .disposed(by: disposeBag)

        return Output(searchPostData: searchPostData.asSignal())
    }
}
