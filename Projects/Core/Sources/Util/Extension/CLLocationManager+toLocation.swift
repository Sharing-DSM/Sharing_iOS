import UIKit
import CoreGraphics
import CoreLocation

public extension CLLocationManager {
    func toLocation(completionHandler: @escaping CLGeocodeCompletionHandler) {
        let findLocation = CLLocation(
            latitude: self.location?.coordinate.latitude ?? 0,
            longitude: self.location?.coordinate.longitude ?? 0
        )
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale) { (place, error) in
            if let address: [CLPlacemark] = place {
                completionHandler(address, error)
            }
        }
    }
}
