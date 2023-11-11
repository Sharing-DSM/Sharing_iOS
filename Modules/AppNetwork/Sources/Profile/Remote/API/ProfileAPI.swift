import Foundation
import Moya
import Core

public enum ProfileAPI {
    case fetchUserProfile
    case patchUserProfile(name: String, id: String, age: Int)
    case postSchedule(title: String, date: Date)
}

extension ProfileAPI: TargetType {
    public var baseURL: URL {
        return URLUtil.baseURL
    }
    
    public var path: String {
        switch self {
        case .fetchUserProfile, .patchUserProfile:
            return "/users"
        case .postSchedule:
            return "/schedules/"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .postSchedule:
            return .post
        case .patchUserProfile:
            return .patch
        case .fetchUserProfile:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .postSchedule(let title, let date) :
            return .requestParameters(
                parameters: [
                    "title": title,
                    "date": date
                ],
                encoding: URLEncoding.queryString)
        case .patchUserProfile(let name, let id, let age):
            return .requestParameters(
                parameters: [
                    "name": name,
                    "account_id": id,
                    "age": age
                ], encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return TokenStorage.shared.toHeader(.accessToken)
    }
}
