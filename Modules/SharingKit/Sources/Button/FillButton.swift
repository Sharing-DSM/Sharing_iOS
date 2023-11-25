import UIKit
import SnapKit
import Then

open class FillButton: UIButton {
    
    public var isLoading: Bool = false {
        didSet {
            isLoading ? loadView.startAnimating() : loadView.stopAnimating()
            self.setTitleColor(isLoading ? UIColor.clear : UIColor.white, for: .normal)
        }
    }
    
    private let loadView = UIActivityIndicatorView(style: .medium).then {
        $0.color = .white
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .main
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
        setLayout()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpButton()
        setLayout()
    }
}

extension FillButton {
    private func setUpButton() {
        self.addSubview(loadView)
        self.backgroundColor = .main
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = .bodyB2Medium
        self.layer.cornerRadius = 10
        self.setShadow()
    }
    
    private func setLayout() {
        loadView.snp.makeConstraints {
            $0.width.height.equalToSuperview()
            $0.center.equalToSuperview()
        }
    }
}
