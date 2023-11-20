import Foundation
import RxSwift

public class CreateChatRoomUseCase {

    let repository: ChatRepository

    public init(repository: ChatRepository) {
        self.repository = repository
    }

    public func execute(userID: String) -> Single<ChatRoomIDEntity> {
        repository.createChatRoom(userID: userID)
    }
}
