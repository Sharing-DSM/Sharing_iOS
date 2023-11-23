import Foundation
import Moya
import Core

public enum PostAPI {
    case fetchPopularityPost
    case fetchPostDetail(id: String)
    case deletePost(id: String)
    case createPost(
        title: String,
        content: String,
        addressName: String,
        roadAddressName: String,
        xCos: Double,
        yCos: Double,
        recruitment: Int,
        type: String,
        volunteerTime: Int,
        isEmergency: Bool
    )
    case editPost(
        id: String,
        title: String,
        content: String,
        addressName: String,
        roadAddressName: String,
        xCos: Double,
        yCos: Double,
        recruitment: Int,
        type: String,
        volunteerTime: Int,
        isEmergency: Bool
    )
    case fetchAreaOfInterestPost
    case fetchSurroundingPost(x: Double, y: Double)
    case fetchEmergencyPost
}

extension PostAPI: TargetType {
    public var baseURL: URL {
        return URLUtil.baseURL
    }
    
    public var path: String {
        switch self {
        case .fetchPopularityPost, .createPost:
            return "/feeds/"
        case .fetchPostDetail(let id), .deletePost(let id), .editPost(let id, _, _, _, _, _, _, _, _, _, _):
            return "/feeds/\(id)"
        case .fetchAreaOfInterestPost:
            return "/feeds/interest-area"
        case .fetchSurroundingPost:
            return "/feeds/map"
        case .fetchEmergencyPost:
            return "/feeds/emergency"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchPopularityPost, 
             .fetchPostDetail,
             .fetchAreaOfInterestPost:
            return .get
        case .createPost, .fetchSurroundingPost:
            return .post
        case .deletePost:
            return .delete
        case .editPost:
            return .patch
        case .fetchEmergencyPost:
            return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .createPost(
            let title,
            let content,
            let addressName,
            let roadAddressName,
            let xCos,
            let yCos,
            let recruitment,
            let type,
            let volunteerTime,
            let isEmergency
        ):
            return .requestParameters(
                parameters: [
                    "title" : title,
                    "content" : content,
                    "address_name": addressName,
                    "road_address_name": roadAddressName,
                    "x": xCos,
                    "y": yCos,
                    "recruitment" : recruitment,
                    "type" : type,
                    "volunteer_time" : volunteerTime,
                    "is_emergency": isEmergency
                ],
                encoding: JSONEncoding.default
            )
        case .editPost(
            _,
            let title,
            let content,
            let addressName,
            let roadAddressName,
            let xCos,
            let yCos,
            let recruitment,
            let type,
            let volunteerTime,
            let isEmergency
        ):
            return .requestParameters(
                parameters: [
                    "title" : title,
                    "content" : content,
                    "address_name": addressName,
                    "road_address_name": roadAddressName,
                    "x": xCos,
                    "y": yCos,
                    "recruitment" : recruitment,
                    "type" : type,
                    "volunteer_time" : volunteerTime,
                    "is_emergency": isEmergency
                ],
                encoding: JSONEncoding.default
            )
        case .fetchSurroundingPost(let x, let y):
            return .requestParameters(
                parameters: [
                    "x": x,
                    "y": y
                ],
                encoding: JSONEncoding.default
            )
        default:
            return .requestPlain
        }
    }

    public var headers: [String: String]? {
        return TokenStorage.shared.toHeader(.accessToken)
    }
}
