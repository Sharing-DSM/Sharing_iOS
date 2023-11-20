import Foundation

public struct UserProfileEntity {
    public let name: String
    public let accountId: String
    public let age: Int

    public init(name: String, accountId: String, age: Int) {
        self.name = name
        self.accountId = accountId
        self.age = age
    }
}
