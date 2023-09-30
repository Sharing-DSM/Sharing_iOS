import Foundation

public protocol ViewModelTransformable: HasViewModel {
    var input: ViewModel.Input { get }
    var output: ViewModel.Output { get }
}
