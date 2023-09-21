import UIKit
import SnapKit
import Then

class ExViewController: UIViewController {

    private let textLable = UITextView().then {
        $0.text = "ExView"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .blue
    }

    override func viewWillLayoutSubviews() {
        view.addSubview(textLable)
        textLable.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
