import Foundation

public struct ApplicantListEntityElement {
    public let userID: String
    public let userProfile: String
    public let userName, appliedAt: String
    
    public init(userID: String, userProfile: String, userName: String, appliedAt: String) {
        self.userID = userID
        self.userProfile = userProfile
        self.userName = userName
        self.appliedAt = appliedAt
    }
}

public typealias ApplicantListEntity = [ApplicantListEntityElement]
