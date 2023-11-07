import Foundation
import Moya
import Core

public enum AddressAPI {
    case fetchAddress(keyword: String, page: Int)
}

extension AddressAPI: TargetType {

    public var baseURL: URL {
        return URLUtil.baseURL
    }
    
    public var path: String {
        return "/feeds/address"
    }
    
    public var method: Moya.Method {
        return .post
    }
    
    public var task: Moya.Task {
        switch self {
        case .fetchAddress(let keyword, let page):
            return .requestParameters(
                parameters: [
                    "keyword": keyword,
                    "page": page,
                    "size": 3
                ],
                encoding: JSONEncoding.default)
        }
    }

    public var headers: [String : String]? {
        return TokenStorage.shared.toHeader(.accessToken)
    }
}
