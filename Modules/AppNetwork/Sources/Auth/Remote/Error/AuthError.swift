import Foundation
import Core

public enum AuthError: Int, BaseError {
    case NOTFOUND = 404
    case WRONGPASSWORD = 400
    case CONFLICT = 409
    case BADSERVER = 500
    case UNOWNDEERROR = 0

    public static func mappingError(rawValue: Int) -> AuthError {
        return AuthError(rawValue: rawValue) ?? .UNOWNDEERROR
    }
}

extension AuthError {
    public var errorDescription: String? {
        switch self {
        case .NOTFOUND:
            return "아이디를 다시 확인해주세요."
        case .WRONGPASSWORD:
            return "올바르지 않은 비밀번호 입니다."
        case .CONFLICT:
            return "이미 존재하는 아이디 입니다.\n다른 아이디로 다시 시도해주세요."
        case .BADSERVER:
            return "관리자에게 문의해주세요.\n500"
        default:
            return "알 수 없는 오류입니다.\n에러코드를 확인하세요."
        }
    }
}
