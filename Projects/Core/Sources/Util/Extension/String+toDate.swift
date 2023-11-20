import Foundation

public extension String {
    func toDate() -> Date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            dateFormatter.timeZone = TimeZone(identifier: "KST")
            if let date = dateFormatter.date(from: self) {
                return date
            } else {
                print("‼️ toDate의 형식이 맞지 않습니다!!")
                return Date()
            }
        }
}
