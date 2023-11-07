import Foundation
import Moya
import Core
import Domain

public enum PostAPI {
    case fetchTotalPost
    case fetchPostDetail(id: String)
    case createPost(
        title: String,
        content: String,
        addressData: AddressEntityElement,
        recruitment: Int,
        type: String,
        volunteerTime: Int,
        isEmergency: Bool
    )
//    case deletePost(id: String)
//    case editPost(id: String)
}

extension PostAPI: TargetType {
    public var baseURL: URL {
        return URLUtil.baseURL
    }
    
    public var path: String {
        switch self {
        case .fetchTotalPost, .createPost:
            return "/feeds/"
        case .fetchPostDetail(let id):
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
        case .fetchTotalPost, .fetchPostDetail:
            return .get
        case .createPost:
            return .post
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
        case .fetchTotalPost, .fetchPostDetail:
            return .requestPlain
        case .createPost(
            let title,
            let content,
            let addressData,
            let recruitment,
            let type,
            let volunteerTime,
            let isEmergency):
            return .requestParameters(
                parameters: [
                    "title" : title,
                    "content" : content,
                    "address_name": addressData.addressName,
                    "road_address_name": addressData.roadAddressName,
                    "x": addressData.x,
                    "y": addressData.y,
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
