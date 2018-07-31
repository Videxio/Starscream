import Foundation

@objc
public protocol StarscreamWebSocketDelegate: class {
    @objc
    func websocketDidConnect(socket: StarscreamWebSocket)
    @objc
    func websocketDidDisconnect(socket: StarscreamWebSocket, error: NSError?)
    @objc
    func websocketDidReceiveMessage(socket: StarscreamWebSocket, text: String)
    @objc
    func websocketDidReceiveData(socket: StarscreamWebSocket, data: Data)
}

@objc
public class StarscreamWebSocket: NSObject, WebSocketDelegate {
    private let socket: WebSocket

    @objc
    public weak var delegate: StarscreamWebSocketDelegate?

    @objc
    public init(url: URL, headers: [String: String]) {
        socket = WebSocket(url: url)
        socket.headers = headers
    }

    @objc
    public func connect() {
        socket.connect()
    }

    @objc
    public func disconnect() {
        socket.disconnect()
    }

    // WebSocketDelegate
    public func websocketDidConnect(socket: WebSocket) {
        self.delegate?.websocketDidConnect(socket: self)
    }
    // WebSocketDelegate
    public func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        self.delegate?.websocketDidDisconnect(socket: self, error: error)
    }
    // WebSocketDelegate
    public func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        self.delegate?.websocketDidReceiveMessage(socket: self, text: text)
    }
    // WebSocketDelegate
    public func websocketDidReceiveData(socket: WebSocket, data: Data) {
        self.delegate?.websocketDidReceiveData(socket: self, data: data)
    }
}
