import Foundation

public struct UserProfileEntity {
    public let name: String
    public let accountId: String
    public let age: Int
    public let profileImageURL: String

    public init(name: String, accountId: String, age: Int, profileImageURL: String) {
        self.name = name
        self.accountId = accountId
        self.age = age
        self.profileImageURL = profileImageURL
    }
}
