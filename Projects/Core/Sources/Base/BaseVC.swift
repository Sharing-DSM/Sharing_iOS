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
        bind()
        attribute()
    }

    public func settingDissmissGesture(target: [UIView]) {
        target.forEach {
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(sender:)))
            tap.cancelsTouchesInView = false
            $0.addGestureRecognizer(tap)
        }
    }

    @objc private func dismissKeyboard(sender: UIView) {
        print(sender)
        view.endEditing(true)
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
