import UIKit
import RxSwift

open class BaseVC<ViewModel: ViewModelType>:
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        bind()
        attribute()
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addView()
        setLayout()
    }

    open func attribute() {}
    open func bind() {}
    open func addView() {}
    open func setLayout() {}
}
