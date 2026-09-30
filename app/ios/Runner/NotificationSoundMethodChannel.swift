import Flutter
import AVFoundation
import Foundation
import UIKit

final class NotificationSoundMethodChannel: NSObject, FlutterPlugin {
  private let queue = DispatchQueue(label: "net.yumnumm.eqmonitor.notification-sounds", qos: .userInitiated)
  private let store = NotificationSoundStore()
  private let previewPlayer = NotificationSoundPreviewPlayer()
  private var preparedFiles: [String: Int] = [:]
  private var didClearPrepared = false
  // Owned by the main thread; invalidates work queued before a stop request.
  private var previewGeneration = 0

  override init() {
    super.init()
    NotificationCenter.default.addObserver(
      self, selector: #selector(stopPreview),
      name: UIApplication.didEnterBackgroundNotification, object: nil
    )
    NotificationCenter.default.addObserver(
      self, selector: #selector(stopPreview),
      name: AVAudioSession.interruptionNotification, object: nil
    )
  }

  deinit { NotificationCenter.default.removeObserver(self) }

  @objc private func stopPreview() {
    previewGeneration += 1
    previewPlayer.stop()
  }

  static func register(with registrar: any FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "net.yumnumm.eqmonitor/notification_sounds", binaryMessenger: registrar.messenger()
    )
    registrar.addMethodCallDelegate(NotificationSoundMethodChannel(), channel: channel)
  }

  func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "stopPreview" {
      stopPreview()
      result(nil)
      return
    }
    let methods = ["inspect", "prepare", "commit", "discard", "list", "rename", "delete", "preview"]
    guard methods.contains(call.method) else { result(FlutterMethodNotImplemented); return }
    let arguments = call.arguments as? [String: Any] ?? [:]
    if ["commit", "discard", "delete", "prepare", "preview"].contains(call.method) {
      stopPreview()
    }
    let generation = previewGeneration
    queue.async {
      do {
        if !self.didClearPrepared {
          try self.store.clearPreparedFiles()
          self.didClearPrepared = true
        }
        if call.method == "preview" {
          let id = try self.string(arguments, "id")
          let url = arguments["prepared"] as? Bool == true
            ? try self.preparedURL(id) : try self.store.savedURL(id: id)
          DispatchQueue.main.async {
            guard self.previewGeneration == generation,
              UIApplication.shared.applicationState == .active
            else { result(nil); return }
            do { try self.previewPlayer.preview(url); result(nil) }
            catch { result(self.flutterError(error)) }
          }
          return
        }
        let value = try self.perform(call.method, arguments: arguments)
        let response = try value.map { value in
          let data = try JSONSerialization.data(withJSONObject: value)
          guard let json = String(data: data, encoding: .utf8) else {
            throw NotificationSoundFailure()
          }
          return json
        }
        DispatchQueue.main.async { result(response) }
      } catch {
        DispatchQueue.main.async { result(self.flutterError(error)) }
      }
    }
  }

  private func perform(_ method: String, arguments: [String: Any]) throws -> Any? {
    let importer = NotificationSoundImporter(store: store)
    switch method {
    case "inspect": return try importer.inspect(sourcePath: string(arguments, "sourcePath"))
    case "prepare":
      let value = try importer.prepare(
        sourcePath: string(arguments, "sourcePath"),
        trimToMaxDuration: arguments["trimToMaxDuration"] as? Bool == true
      )
      guard let id = value["id"] as? String, let duration = value["durationMs"] as? Int else {
        throw NotificationSoundFailure("invalidAudio")
      }
      preparedFiles[id] = duration
      return value
    case "commit":
      let id = try string(arguments, "id")
      let duration = try importer.validate(preparedURL(id))
      let value = try store.commit(id: id, displayName: string(arguments, "displayName"), durationMs: duration)
      preparedFiles.removeValue(forKey: id)
      return value
    case "discard":
      let id = try string(arguments, "id")
      try store.discard(id: id)
      preparedFiles.removeValue(forKey: id)
    case "list": return ["sounds": try store.list()]
    case "rename": try store.rename(id: string(arguments, "id"), displayName: string(arguments, "displayName"))
    case "delete": try store.delete(id: string(arguments, "id"))
    default: throw NotificationSoundFailure("invalidAudio")
    }
    return nil
  }

  private func preparedURL(_ id: String) throws -> URL {
    guard preparedFiles[id] != nil else { throw NotificationSoundFailure("sourceUnavailable") }
    return try store.preparedURL(id: id)
  }

  private func string(_ arguments: [String: Any], _ key: String) throws -> String {
    guard let value = arguments[key] as? String, !value.isEmpty else {
      throw NotificationSoundFailure("invalidAudio")
    }
    return value
  }

  private func flutterError(_ error: Error) -> FlutterError {
    let code = (error as? NotificationSoundFailure)?.code ?? "storageFailure"
    return FlutterError(code: code, message: "Notification sound operation failed", details: nil)
  }
}
