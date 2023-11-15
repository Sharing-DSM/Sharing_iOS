import Foundation
import RxSwift
import RxCocoa
import RxFlow
import Core
import Domain

public class ChatViewModel: ViewModelType, Stepper {

    public var steps = PublishRelay<Step>()
    public var disposeBag = DisposeBag()

    public init() {}


    public struct Input {
    }

    public struct Output {
    }

    public func transform(input: Input) -> Output {

        return Output()
    }
}
