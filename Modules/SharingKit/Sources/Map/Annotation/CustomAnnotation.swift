import UIKit
import MapKit

public class CustomAnnotation: NSObject, MKAnnotation {
    @objc dynamic public var coordinate: CLLocationCoordinate2D

    public init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
