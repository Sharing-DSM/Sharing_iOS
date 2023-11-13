import Foundation
import Core

public enum PostError: Int, BaseError {
    case NOTFOUND = 404
    case WRONGPASSWORD = 400
    case BADSERVER = 500
    case UNOWNDEERROR = 0

    public static func mappingError(rawValue: Int) -> Self {
        return Self(rawValue: rawValue) ?? .UNOWNDEERROR
    }
}

extension PostError {
    public var errorDescription: String? {
        switch self {
        case .NOTFOUND:
            return "찾을 수 없는 게시물 입니다."
        case .WRONGPASSWORD:
            return "올바르지 않은 요청입니다."
        case .BADSERVER:
            return "관리자에게 문의해주세요.\n500"
        default:
            return "알 수 없는 오류입니다.\n에러코드를 확인하세요."
        }
    }
}
