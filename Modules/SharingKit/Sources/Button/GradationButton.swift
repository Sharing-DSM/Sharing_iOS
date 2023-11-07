import UIKit

public class GradationButton: UIButton {

    public override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        setShadow()
     }

    lazy var gradientLayer: CAGradientLayer = {
        let gradation = CAGradientLayer()
        gradation.cornerRadius = 35
        gradation.frame = self.bounds
        gradation.colors = [UIColor.blue1?.cgColor as Any, UIColor.blue2?.cgColor as Any]
        gradation.startPoint = CGPoint(x: 0.5, y: 0)
        gradation.endPoint = CGPoint(x: 0.5, y: 1)
        layer.insertSublayer(gradation, at: 0)
        return gradation
    }()
}
