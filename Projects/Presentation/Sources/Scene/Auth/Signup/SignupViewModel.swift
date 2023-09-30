import Foundation
import RxSwift
import RxCocoa

public class SignupViewModel: ViewModelType {
    public init() {}
    public var disposeBag: DisposeBag = DisposeBag()
    
    public struct Input {
        
    }

    public struct Output {
    }

    public func transform(input: Input) -> Output {
        return Output()
    }
}
