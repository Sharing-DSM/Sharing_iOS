import Foundation
import RxSwift
import Moya
import RxMoya
import AppNetwork
import AppLogger

class ChatDataSource {

    private let provider = MoyaProvider<ChatAPI>(plugins: [MoyaLoggingPlugin()])

    static let shared = ChatDataSource()
    private init() {}

    func createChatRoom(userID: String) -> Single<Response> {
        return provider.rx.request(.createChatRoom(userID: userID))
            .filterSuccessfulStatusCodes()
            .catch { .error($0.toError(ChatError.self))}
    }

    func fetchChatList() -> Single<Response> {
        return provider.rx.request(.fetchChatList)
            .filterSuccessfulStatusCodes()
            .catch { .error($0.toError(ChatError.self))}
    }

    func fetchChatContent(roomID: String) -> Single<Response> {
        return provider.rx.request(.fetchChatContent(roomID: roomID))
            .filterSuccessfulStatusCodes()
            .catch { .error($0.toError(ChatError.self))}
    }
}
