import Foundation
import Core

public enum ChatError: Int, BaseError {
    case NOTFOUND = 404
    case ALREADYROOM = 409
    case BADSERVER = 500
    case UNOWNDEERROR = 0

    public static func mappingError(rawValue: Int) -> Self {
        return Self(rawValue: rawValue) ?? .UNOWNDEERROR
    }
}

extension ChatError {
    public var errorDescription: String? {
        switch self {
        case .NOTFOUND:
            return "찾을 수 없는 채팅입니다."
        case .BADSERVER:
            return "관리자에게 문의해주세요.\n500"
        case .ALREADYROOM:
            return "이미 참여한 채팅입니다."
        default:
            return "알 수 없는 오류입니다.\n에러코드를 확인하세요."
        }
    }
}
