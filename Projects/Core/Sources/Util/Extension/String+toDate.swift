import Foundation

public extension String {
    func toDate(_ format: DateFormatIndicated) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            print("‼️ toDate의 형식이 맞지 않습니다!!")
            return Date()
        }
    }
}
