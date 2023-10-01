import Foundation

public protocol ViewModelType: HasDisposeBag {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
