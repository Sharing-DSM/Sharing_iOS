import UIKit
import RxSwift
import SharingKit

public class BaseVC<ViewModel: ViewModelType>:
    UIViewController,
    HasViewModel,
    HasDisposeBag,
    ViewModelBindable
{
    public var viewModel: ViewModel
    public var disposeBag: DisposeBag = DisposeBag()

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bind()
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addView()
        setLayout()
    }

    public func bind() {}
    public func addView() {}
    public func setLayout() {}
}
