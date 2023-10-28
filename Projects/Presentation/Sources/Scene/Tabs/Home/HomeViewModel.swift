import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Core
import Domain

public class HomeViewModel: Stepper {
    public var steps = PublishRelay<Step>()
    public var disposeBag: DisposeBag = DisposeBag()
    
}
