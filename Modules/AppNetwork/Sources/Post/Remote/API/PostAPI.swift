import Foundation
import Moya
import Core

public enum PostAPI {
    case fetchPopularityPost
    case fetchPostDetail(id: String)
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
    case deletePost(id: String)
//    case editPost(id: String)
}

extension PostAPI: TargetType {
    public var baseURL: URL {
        return URLUtil.baseURL
    }
    
    public var path: String {
        switch self {
        case .fetchPopularityPost, .createPost:
            return "/feeds/"
        case .fetchPostDetail(let id), .deletePost(let id):
            return "/feeds/\(id)"
//        case .createPost:
//            return "/feeds/"
//        case .deletePost(let id):
//            return "/feeds/\(id)"
//        case .editPost(let id):
//            return "/feeds/\(id)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchPopularityPost, .fetchPostDetail:
            return .get
        case .createPost:
            return .post
        case .deletePost:
            return .delete
//        case .createPost:
//            return .post
//        case .editPost:
//            return .patch
//        case .deletePost:
//            return .delete
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .fetchPopularityPost, .fetchPostDetail, .deletePost:
            return .requestPlain
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
        }
    }

    public var headers: [String: String]? {
        return TokenStorage.shared.toHeader(.accessToken)
    }
}
