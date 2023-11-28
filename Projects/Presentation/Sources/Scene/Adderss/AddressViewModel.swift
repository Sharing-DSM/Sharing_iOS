import RxSwift
import RxCocoa
import RxFlow
import Core
import Domain

public class AddressViewModel: ViewModelType, Stepper {

    public var disposeBag = DisposeBag()
    public var steps = PublishRelay<Step>()

    private let fetchAddressUseCase: FetchAddressUseCase

    public init(fetchAddressUseCase: FetchAddressUseCase) {
        self.fetchAddressUseCase = fetchAddressUseCase
    }

    private var addressPage: Int = 1

    private let addressDatas = PublishRelay<[AddressEntityElement]>()
    private let totalPage = BehaviorRelay<String>(value: "- / -")
    private let isEndOfLeftPage = BehaviorRelay<Bool>(value: true)
    private let isEndOfRightPage = BehaviorRelay<Bool>(value: true)
    
    public struct Input {
        let searchAddress: Observable<String>
        let searchBarText: Observable<String>
        let leftPageButttoDidClick: Observable<Void>
        let rightPageButttoDidClick: Observable<Void>
    }

    public struct Output{
        let addressDatas: Signal<[AddressEntityElement]>
        let totalPage: Driver<String>
        let isEndOfLeftPage: Driver<Bool>
        let isEndOfRightPage: Driver<Bool>
    }

    public func transform(input: Input) -> Output {

        input.searchAddress
            .flatMap  {
                self.fetchAddressUseCase.execute(keyword: $0, page: self.addressPage)
                    .catch {
                        print($0.localizedDescription)
                        return .empty()
                    }
            }
            .subscribe(
                with: self,
                onNext: { owner, data in
                    owner.addressPage = 1
                    owner.addressDatas.accept(data.address)
                    owner.totalPage.accept("\(owner.addressPage) / \(data.totalPage)")
                    owner.isEndOfLeftPage.accept(owner.addressPage <= 1)
                    owner.isEndOfRightPage.accept(owner.addressPage >= data.totalPage)
            })
            .disposed(by: disposeBag)

        input.rightPageButttoDidClick.withLatestFrom(input.searchBarText)
            .flatMap {
                self.fetchAddressUseCase.execute(keyword: $0, page: self.addressPage + 1)
                    .catch {
                        print($0.localizedDescription)
                        return .empty()
                    }
            }
            .subscribe(
                with: self,
                onNext: { owner, data in
                    owner.addressPage += 1
                    owner.addressDatas.accept(data.address)
                    owner.totalPage.accept("\(owner.addressPage) / \(data.totalPage)")
                    owner.isEndOfLeftPage.accept(owner.addressPage <= 1)
                    owner.isEndOfRightPage.accept(owner.addressPage >= data.totalPage)
                }
            )
            .disposed(by: disposeBag)

        input.leftPageButttoDidClick.withLatestFrom(input.searchBarText)
            .flatMap {
                self.fetchAddressUseCase.execute(keyword: $0, page: self.addressPage - 1)
                    .catch {
                        print($0.localizedDescription)
                        return .empty()
                    }
            }
            .subscribe(
                with: self,
                onNext: { owner, data in
                    owner.addressPage -= 1
                    owner.addressDatas.accept(data.address)
                    owner.totalPage.accept("\(owner.addressPage) / \(data.totalPage)")
                    owner.isEndOfLeftPage.accept(owner.addressPage <= 1)
                    owner.isEndOfRightPage.accept(owner.addressPage >= data.totalPage)
                }
            )
            .disposed(by: disposeBag)
            

        return Output(
            addressDatas: addressDatas.asSignal(),
            totalPage: totalPage.asDriver(),
            isEndOfLeftPage: isEndOfLeftPage.asDriver(),
            isEndOfRightPage: isEndOfRightPage.asDriver()
        )
    }
}
