import Foundation
import RxSwift
import RxCocoa
import Domain

public class MapViewModel: ViewModelType {
    public var disposeBag = DisposeBag()

    public init() { }
    
    public struct Input {
        
    }
    
    public struct Output {
        
    }

    public func transform(input: Input) -> Output {
        return Output()
    }
}
