import UIKit
import MapKit
import SnapKit
import Then

public class CoustomAnnotationView: MKAnnotationView {
    private let annotationImageView = UIImageView(image: .annotation)

    override public init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        centerOffset = CGPoint(x: -14, y: -44)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(annotationImageView)
        annotationImageView.snp.makeConstraints {
            $0.height.equalTo(46)
            $0.width.equalTo(28)
        }
    }

    override public func prepareForReuse() {
        super.prepareForReuse()
        setNeedsLayout()
    }
}
