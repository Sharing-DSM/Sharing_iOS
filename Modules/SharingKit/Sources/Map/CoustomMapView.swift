import UIKit
import MapKit

public class CoustomMapView: MKMapView {
    public init() {
        super.init(frame: .zero)
        preferredConfiguration = MKStandardMapConfiguration()
        isZoomEnabled = true // 줌 가능 여부
        isScrollEnabled = true // 이동 가능 여부
        isPitchEnabled = true // 각도조절 가능 여부
        isRotateEnabled = true //회전 가능 여부
        showsCompass = false // 나침판 표시 여부
        showsScale = false // 축척 정보 표시 여부
        showsUserLocation = true // 위치 사용 시 사용자의 현재 위치를 표시
        register(CoustomAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(CoustomAnnotationView.self))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
