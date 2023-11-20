import Foundation
import SocketIO
import Core

public class BaseSocketManager: SocketManager {
    public init() {
        super.init(
            socketURL: URLUtil.socketURL,
            config: [.log(true), .compress]
        )

        self.config = SocketIOClientConfiguration(
            arrayLiteral:
            .extraHeaders(TokenStorage.shared.toHeader(.accessToken)),
            .version(.two),
            .path("/socket.io"),
            .reconnects(true)
        )
    }
}
