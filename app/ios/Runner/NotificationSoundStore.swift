import Foundation

struct NotificationSoundFailure: Error {
  let code: String
  let stage: String?
  let underlyingError: NSError?

  init(_ code: String = "storageFailure", stage: String? = nil, underlyingError: Error? = nil) {
    self.code = code
    self.stage = stage
    self.underlyingError = underlyingError.map { $0 as NSError }
  }
}

struct CustomNotificationSoundRecord: Codable {
  let id: String
  var displayName: String
  let fileName: String
  let durationMs: Int
  let createdAt: Date

  func dictionary(isAvailable: Bool) -> [String: Any] {
    [
      "id": id, "displayName": displayName, "fileName": fileName,
      "durationMs": durationMs,
      "createdAt": ISO8601DateFormatter().string(from: createdAt),
      "isAvailable": isAvailable,
    ]
  }
}

private struct NotificationSoundCatalog: Codable {
  var schemaVersion = 1
  var sounds: [CustomNotificationSoundRecord] = []
}

/// Accessed only on NotificationSoundMethodChannel's serial worker queue.
final class NotificationSoundStore {
  private let manager = FileManager.default

  func directory(_ relativePath: String) throws -> URL {
    guard let root = manager.containerURL(
      forSecurityApplicationGroupIdentifier: "group.net.yumnumm.eqmonitor"
    ) else { throw NotificationSoundFailure() }
    let url = root.appendingPathComponent(relativePath, isDirectory: true)
    try manager.createDirectory(
      at: url, withIntermediateDirectories: true,
      attributes: [.protectionKey: FileProtectionType.completeUntilFirstUserAuthentication]
    )
    return url
  }

  func preparedURL(id: String) throws -> URL {
    guard Self.validID(id) else { throw NotificationSoundFailure("invalidAudio") }
    return try directory("Library/Caches/NotificationSoundImports")
      .appendingPathComponent("\(id).wav")
  }

  func savedURL(id: String) throws -> URL {
    guard let record = try readCatalog().sounds.first(where: { $0.id == id }) else {
      throw NotificationSoundFailure("sourceUnavailable")
    }
    let url = try directory("Library/Sounds").appendingPathComponent(record.fileName)
    guard manager.fileExists(atPath: url.path) else {
      throw NotificationSoundFailure("sourceUnavailable")
    }
    return url
  }

  func list() throws -> [[String: Any]] {
    let catalog = try readCatalog()
    let sounds = try directory("Library/Sounds")
    let registered = Set(catalog.sounds.map(\.fileName))
    for url in try manager.contentsOfDirectory(at: sounds, includingPropertiesForKeys: nil) {
      if Self.validFileName(url.lastPathComponent), !registered.contains(url.lastPathComponent) {
        try manager.removeItem(at: url)
      }
    }
    return catalog.sounds.map {
      $0.dictionary(isAvailable: manager.fileExists(
        atPath: sounds.appendingPathComponent($0.fileName).path
      ))
    }
  }

  func commit(id: String, displayName: String, durationMs: Int) throws -> [String: Any] {
    var catalog = try readCatalog()
    let name = try validatedName(displayName)
    guard Self.validID(id), !catalog.sounds.contains(where: { $0.id == id }) else {
      throw NotificationSoundFailure("invalidAudio")
    }
    let record = CustomNotificationSoundRecord(
      id: id, displayName: name, fileName: "eqm_custom_\(id).wav",
      durationMs: durationMs, createdAt: Date()
    )
    let source = try preparedURL(id: id)
    let destination = try directory("Library/Sounds").appendingPathComponent(record.fileName)
    try manager.moveItem(at: source, to: destination)
    do {
      try protect(destination)
      catalog.sounds.append(record)
      try writeCatalog(catalog)
    } catch {
      // Preserve the prepared file so a failed commit can be retried.
      try? manager.moveItem(at: destination, to: source)
      throw error
    }
    return record.dictionary(isAvailable: true)
  }

  func rename(id: String, displayName: String) throws {
    var catalog = try readCatalog()
    guard let index = catalog.sounds.firstIndex(where: { $0.id == id }) else {
      throw NotificationSoundFailure("sourceUnavailable")
    }
    catalog.sounds[index].displayName = try validatedName(displayName)
    try writeCatalog(catalog)
  }

  func delete(id: String) throws {
    var catalog = try readCatalog()
    guard let record = catalog.sounds.first(where: { $0.id == id }) else { return }
    catalog.sounds.removeAll(where: { $0.id == id })
    try writeCatalog(catalog)
    let url = try directory("Library/Sounds").appendingPathComponent(record.fileName)
    if manager.fileExists(atPath: url.path) { try manager.removeItem(at: url) }
  }

  func discard(id: String) throws {
    let url = try preparedURL(id: id)
    if manager.fileExists(atPath: url.path) { try manager.removeItem(at: url) }
  }

  func clearPreparedFiles() throws {
    let directory = try directory("Library/Caches/NotificationSoundImports")
    for url in try manager.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil) {
      let id = url.deletingPathExtension().lastPathComponent
      if url.pathExtension == "wav", Self.validID(id) { try manager.removeItem(at: url) }
    }
  }

  func protect(_ url: URL) throws {
    try manager.setAttributes(
      [.protectionKey: FileProtectionType.completeUntilFirstUserAuthentication],
      ofItemAtPath: url.path
    )
  }

  private func readCatalog() throws -> NotificationSoundCatalog {
    let url = try catalogURL()
    if !manager.fileExists(atPath: url.path) {
      let sounds = try directory("Library/Sounds")
      let existing = try manager.contentsOfDirectory(at: sounds, includingPropertiesForKeys: nil)
      guard !existing.contains(where: { Self.validFileName($0.lastPathComponent) }) else {
        throw NotificationSoundFailure()
      }
      let empty = NotificationSoundCatalog()
      try writeCatalog(empty)
      return empty
    }
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    let catalog = try decoder.decode(NotificationSoundCatalog.self, from: Data(contentsOf: url))
    guard catalog.schemaVersion == 1,
      Set(catalog.sounds.map(\.id)).count == catalog.sounds.count,
      catalog.sounds.allSatisfy({
        Self.validID($0.id) && $0.fileName == "eqm_custom_\($0.id).wav"
          && !$0.displayName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
          && $0.durationMs > 0 && $0.durationMs <= NotificationSoundImporter.maxDurationMs
      })
    else { throw NotificationSoundFailure() }
    return catalog
  }

  private func writeCatalog(_ catalog: NotificationSoundCatalog) throws {
    let encoder = JSONEncoder()
    encoder.dateEncodingStrategy = .iso8601
    let url = try catalogURL()
    try encoder.encode(catalog).write(to: url, options: [.atomic, .completeFileProtectionUntilFirstUserAuthentication])
  }

  private func catalogURL() throws -> URL {
    try directory("Library/Application Support/NotificationSounds")
      .appendingPathComponent("catalog.json")
  }

  private func validatedName(_ value: String) throws -> String {
    let name = value.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !name.isEmpty, name.count <= 100 else { throw NotificationSoundFailure("invalidName") }
    return name
  }

  private static func validID(_ id: String) -> Bool {
    id.range(of: "^[a-f0-9]{32}$", options: .regularExpression) != nil
  }

  private static func validFileName(_ name: String) -> Bool {
    name.range(of: "^eqm_custom_[a-f0-9]{32}\\.wav$", options: .regularExpression) != nil
  }
}
