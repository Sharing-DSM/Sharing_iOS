import Foundation

public protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func tarnsform(input: Input) -> Output
}
