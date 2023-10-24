import UIKit

public extension String {
    func isCorrectID() -> Bool {
        return (self.range(of: "^[A-Za-z0-9~!@#$%^&*]{5,15}$", options: .regularExpression) != nil)
    }

    func isCorrectPassword() -> Bool {
        return (self.range(of: "(?=.*[a-z])(?=.*[0-9])(?=.*[!/?@])[a-zA-Z0-9!/?@]{8,20}$", options: .regularExpression) != nil)
    }

    func isCorrectName() -> Bool {
        return (self.range(of: "^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z]{1,5}$", options: .regularExpression) != nil)
    }

    func isCorrectAge() -> Bool {
        return (self.range(of: "^[0-9]{1,2}$", options: .regularExpression) != nil)
    }
}
