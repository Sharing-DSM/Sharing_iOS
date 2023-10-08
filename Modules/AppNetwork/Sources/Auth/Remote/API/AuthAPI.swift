import Foundation
import Moya
import Core

public enum AuthAPI {
    case login(accountID: String, password: String)
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
        case .login(let accountID, let password):
            return .requestParameters(
                parameters: [
                    "account_id": accountID,
                    "password": password
                ],
                encoding: JSONEncoding.default)

        case .signup(let accountID, let password, let name, let age):
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
