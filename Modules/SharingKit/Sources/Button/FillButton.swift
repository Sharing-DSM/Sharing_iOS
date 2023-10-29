import UIKit


open class FillButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpButton()
     }
     
    required public init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         setUpButton()
     }
}

extension FillButton {
    private func setUpButton() {
        self.backgroundColor = .main
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = .bodyB2Medium
        self.layer.cornerRadius = 10
        self.setShadow()
    }
}
