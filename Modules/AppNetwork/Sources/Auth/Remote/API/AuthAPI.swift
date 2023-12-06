import Foundation
import Moya
import Core

public enum AuthAPI {
    case login(accountID: String, password: String, deviceToken: String)
    case signup(accountID: String, password: String, name: String, age: Int)
}

extension AuthAPI: TargetType {
    public var baseURL: URL {
        return URLUtil.baseURL
    }
    
    public var path: String {
        switch self {
        case .login:
            return "/users/login"
        case .signup:
            return "/users/signup"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .login, .signup:
            return .post
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case let .login(accountID, password, deviceToken):
            return .requestParameters(
                parameters: [
                    "account_id": accountID,
                    "password": password,
                    "device_token": deviceToken
                ],
                encoding: JSONEncoding.default)

        case let .signup(accountID, password, name, age):
            return .requestParameters(
                parameters: [
                    "account_id": accountID,
                    "password": password,
                    "name" : name,
                    "age" : age
                ],
                encoding: JSONEncoding.default)
        }
    }

    public var headers: [String: String]? {
        return TokenStorage.shared.toHeader(.tokenIsEmpty)
    }
}
