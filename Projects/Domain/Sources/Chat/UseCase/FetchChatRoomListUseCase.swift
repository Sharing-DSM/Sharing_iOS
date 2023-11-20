import Foundation
import RxSwift

public class FetchChatRoomListUseCase {

    let repository: ChatRepository

    public init(repository: ChatRepository) {
        self.repository = repository
    }

    public func execute() -> Single<ChatListEntity> {
        repository.fetchChatList()
    }
}
