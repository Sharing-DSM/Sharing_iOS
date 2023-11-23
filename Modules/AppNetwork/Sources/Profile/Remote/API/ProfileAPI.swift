import Foundation
import Moya
import Core

public enum ProfileAPI {
    case fetchUserProfile
    case patchUserProfile(name: String, id: String, age: Int)
    case uploadProfileImage(imageData: Data)
    case setAreaOfInterest(addressName: String)

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
        case .uploadProfileImage:
            return "/users/upload"
        case .setAreaOfInterest:
            return "/users"

        case .fetchCompleteSchedules:
            return "/schedules/is-completed"
        case .fetchUnCompleteSchedule:
            return "/schedules"
        case .postSchedules:
            return "/schedules"
        case .patchSchedules(let id, _, _):
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
        case .postSchedules,
             .uploadProfileImage:
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
        case .completScheules,
             .setAreaOfInterest:
            return .put
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .postSchedules(let title, let date):
            return .requestParameters(
                parameters: [
                    "title": title,
                    "date": date
                ],
                encoding: JSONEncoding.default)
        case .uploadProfileImage(let imageData):
            let pngData = MultipartFormData(
                provider: .data(imageData),
                name: "profile",
                fileName: "profile.png",
                mimeType: "profile/png"
            )
            return .uploadMultipart([pngData])

        case .patchUserProfile(let name, let id, let age):
            return .requestParameters(
                parameters: [
                    "name": name,
                    "account_id": id,
                    "age": age
                ], encoding: JSONEncoding.default)
        case .setAreaOfInterest(let addressName):
            return .requestParameters(
                parameters: [
                    "interest-area": addressName
                ], encoding: URLEncoding.queryString)
        case .completScheules:
            return .requestParameters(
                parameters: [
                "completed" : true
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
