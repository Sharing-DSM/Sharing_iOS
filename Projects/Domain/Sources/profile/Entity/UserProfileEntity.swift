import Foundation

public struct UserProfileEntity {
    public let name: String
    public let accountId: String

    public init(name: String, accountId: String) {
        self.name = name
        self.accountId = accountId
    }
}
