import Foundation
import Moya
import Core

public enum ChatAPI {
    case createChatRoom(userID: String)
    case fetchChatList
    case fetchChatContent(roomID: String)
}

extension ChatAPI: TargetType {

    public var baseURL: URL {
        return URLUtil.baseURL
    }
    
    public var path: String {
        switch self {
        case .createChatRoom(let userID):
            return "/chats/\(userID)"
        case .fetchChatList:
            return "/chats/room"
        case .fetchChatContent(let roomID):
            return "/chats/\(roomID)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .fetchChatList, .fetchChatContent:
            return .get
        case .createChatRoom:
            return .post
        }
    }
    
    public var task: Moya.Task {
        return .requestPlain
    }

    public var headers: [String : String]? {
        return TokenStorage.shared.toHeader(.accessToken)
    }
}
