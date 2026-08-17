import Flutter
import Foundation

final class ApnsTokenEventChannel: NSObject, FlutterStreamHandler {
  static let shared = ApnsTokenEventChannel()

  private static let channelName = "net.yumnumm.eqmonitor/apns-token"

  private var latestToken: String?
  private var eventSink: FlutterEventSink?

  private override init() {
    super.init()
  }

  static func register(with registrar: any FlutterPluginRegistrar) {
    let channel = FlutterEventChannel(
      name: channelName,
      binaryMessenger: registrar.messenger()
    )
    channel.setStreamHandler(shared)
  }

  func publish(_ deviceToken: Data) {
    guard !deviceToken.isEmpty else {
      return
    }
    let token = deviceToken.map { byte in
      String(format: "%02x", byte)
    }.joined()
    latestToken = token
    eventSink?(token)
  }

  func onListen(
    withArguments arguments: Any?,
    eventSink events: @escaping FlutterEventSink
  ) -> FlutterError? {
    eventSink = events
    if let latestToken {
      events(latestToken)
    }
    return nil
  }

  func onCancel(withArguments arguments: Any?) -> FlutterError? {
    eventSink = nil
    return nil
  }
}
