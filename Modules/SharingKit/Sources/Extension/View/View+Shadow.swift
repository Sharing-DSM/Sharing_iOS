import UIKit

public extension UIView {
    func setShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.25
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 2
    }
}
