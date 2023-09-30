import Foundation

public protocol HasViewModel {
    associatedtype ViewModel: ViewModelType
    var viewModel: ViewModel { get }
}
