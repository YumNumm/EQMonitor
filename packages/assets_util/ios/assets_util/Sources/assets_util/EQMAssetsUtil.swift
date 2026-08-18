import Foundation

@objc(EQMAssetsUtil)
@objcMembers public class EQMAssetsUtil: NSObject {
  public func resolveLocalPath(fileName: String) -> String? {
    let name = fileName as NSString
    let base = name.deletingPathExtension
    let ext = name.pathExtension
    guard !base.isEmpty else {
      return nil
    }
    return Bundle.main.path(
      forResource: base,
      ofType: ext.isEmpty ? nil : ext
    )
  }

  public func resolvePackRoot(
    packIdentifier: String,
    completion: @escaping (NSString?) -> Void
  ) {
    completion(resolveBundledPackRoot(directoryName: packIdentifier) as NSString?)
  }

  public func resolveAssetPackFile(
    relativePath: String,
    packIdentifier: String,
    completion: @escaping (NSString?) -> Void
  ) {
    guard
      isSafeRelativePath(relativePath),
      let root = resolveBundledPackRoot(directoryName: packIdentifier)
    else {
      completion(nil)
      return
    }
    let rootURL = URL(fileURLWithPath: root, isDirectory: true)
      .standardizedFileURL
    let fileURL = rootURL.appendingPathComponent(relativePath)
      .standardizedFileURL
    guard
      fileURL.path.hasPrefix(rootURL.path + "/"),
      let attributes = try? FileManager.default.attributesOfItem(
        atPath: fileURL.path
      ),
      attributes[.type] as? FileAttributeType == .typeRegular
    else {
      completion(nil)
      return
    }
    completion(fileURL.path as NSString)
  }

  public func diagnoseAssetPack(
    packIdentifier: String,
    completion: @escaping (NSString) -> Void
  ) {
    let root = resolveBundledPackRoot(directoryName: packIdentifier)
    let ready = root != nil
    let json: [String: Any] = [
      "schema_version": 3,
      "platform": platformName,
      "os_version": ProcessInfo.processInfo.operatingSystemVersionString,
      "pack_id": packIdentifier,
      "status": ready ? "ready" : "manifestMissing",
      "detail": ready
        ? "The app-bundled Asset Pack is available."
        : "The app-bundled Asset Pack is missing.",
      "pack_root": root.map { $0 as Any } ?? NSNull(),
    ]
    completion(jsonString(json) as NSString)
  }

  func resolveBundledPackRoot(directoryName: String) -> String? {
    guard
      isSafeDirectoryName(directoryName),
      let resourceURL = Bundle.main.resourceURL
    else {
      return nil
    }
    let directoryURL = resourceURL.appendingPathComponent(
      directoryName,
      isDirectory: true
    )
    let manifestURL = directoryURL.appendingPathComponent("manifest.json")
    var isDirectory: ObjCBool = false
    guard
      FileManager.default.fileExists(
        atPath: directoryURL.path,
        isDirectory: &isDirectory
      ),
      isDirectory.boolValue,
      FileManager.default.fileExists(atPath: manifestURL.path)
    else {
      return nil
    }
    return directoryURL.path
  }

  func isSafeDirectoryName(_ value: String) -> Bool {
    !value.isEmpty && !value.contains("/") && value != "." && value != ".."
  }

  func isSafeRelativePath(_ value: String) -> Bool {
    guard !value.isEmpty, !value.hasPrefix("/"), !value.contains("\\") else {
      return false
    }
    return value.split(separator: "/", omittingEmptySubsequences: false).allSatisfy {
      !$0.isEmpty && $0 != "." && $0 != ".."
    }
  }

  var platformName: String {
    #if os(iOS)
    return "ios"
    #elseif os(macOS)
    return "macos"
    #else
    return "unknown"
    #endif
  }

  func jsonString(_ value: [String: Any]) -> String {
    guard
      let data = try? JSONSerialization.data(
        withJSONObject: value,
        options: [.sortedKeys]
      )
    else {
      return "{}"
    }
    return String(decoding: data, as: UTF8.self)
  }
}
