import UIKit
import SnapKit
import Then

public class ExViewController: UIViewController {

    private let textLable = UITextView().then {
        $0.text = "ExView"
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .blue
    }

    public override func viewWillLayoutSubviews() {
        view.addSubview(textLable)
        textLable.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
