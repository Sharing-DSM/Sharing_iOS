import UIKit

public extension UIButton {
    func setButtonShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 4
    }
}
