import Foundation
import Moya
import Core

public enum ProfileAPI {
    case fetchUserProfile
    case patchUserProfile(name: String, id: String, age: Int)

    case postSchedules(title: String, date: String)
    case fetchCompleteSchedules
    case fetchUnCompleteSchedule
    case fetchMyPost
    case fetchApplyHistory
    case patchSchedules(id: String, title: String, date: String)
    case deleteSchedules(id: String)
    case completScheules(id: String)
}

extension ProfileAPI: TargetType {
    public var baseURL: URL {
        return URLUtil.baseURL
    }
    
    public var path: String {
        switch self {
        case .fetchUserProfile, .patchUserProfile:
            return "/users"
        case .fetchCompleteSchedules:
            return "/schedules/is-completed"
        case .fetchUnCompleteSchedule:
            return "/schedules"
        case .postSchedules:
            return "/schedules"
        case .patchSchedules(let id, let title, let date):
            return "schedules/\(id)"
        case .deleteSchedules(let id):
            return "/schedules/\(id)"
        case .completScheules(let id):
            return "schedules/check/\(id)"
        case .fetchMyPost:
            return "/feeds/mine"
        case .fetchApplyHistory:
            return "feeds/apply"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .postSchedules:
            return .post
        case .patchUserProfile, 
             .patchSchedules:
            return .patch
        case .fetchUserProfile, 
             .fetchCompleteSchedules,
             .fetchUnCompleteSchedule,
             .fetchMyPost,
             .fetchApplyHistory:
            return .get
        case .deleteSchedules:
            return .delete
        case .completScheules:
            return .put
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .postSchedules(let title, let date) :
            return .requestParameters(
                parameters: [
                    "title": title,
                    "date": date
                ],
                encoding: JSONEncoding.default)
        case .patchUserProfile(let name, let id, let age):
            return .requestParameters(
                parameters: [
                    "name": name,
                    "account_id": id,
                    "age": age
                ], encoding: JSONEncoding.default)
        case .completScheules:
            return .requestParameters(
                parameters: [
                "is_completed" : false
                ], encoding: JSONEncoding.default)
        case .patchSchedules(_, let title, let date):
            return .requestParameters(
                parameters: [
                    "title": title,
                    "date": date
                ], encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return TokenStorage.shared.toHeader(.accessToken)
    }
}
