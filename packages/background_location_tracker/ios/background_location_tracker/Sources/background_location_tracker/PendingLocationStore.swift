import Darwin
import Foundation

enum BackgroundLocationStorageKey {
    static let callbackHandle = "blt_callback_handle"

    static let legacyLatitude = "blt_pending_lat"
    static let legacyLongitude = "blt_pending_lon"
    static let legacyTimestampSeconds = "blt_pending_ts"

    static let roundZeroUpdateId = "blt_pending_update_id"
    static let roundZeroLatitude = "blt_pending_latitude"
    static let roundZeroLongitude = "blt_pending_longitude"
    static let roundZeroAccuracy = "blt_pending_accuracy"
    static let roundZeroTimestampMillis = "blt_pending_timestamp_millis"
    static let roundZeroDeviceLocationPending = "blt_pending_device_location"
    static let roundZeroAppEffectsPending = "blt_pending_app_effects"
}

struct StoredPendingLocation: Equatable {
    let updateId: String
    let latitude: Double
    let longitude: Double
    let accuracy: Double
    let timestampMillis: Int64
}

enum PendingLocationRecordStorageReadResult {
    case missing
    case data(Data)
    case failure
}

protocol PendingLocationRecordStorage: AnyObject {
    func read() -> PendingLocationRecordStorageReadResult
    func write(_ data: Data) -> Bool
    func remove() -> Bool
}

protocol PendingLocationDataWriting {
    func write(
        _ data: Data,
        to fileURL: URL,
        options: Data.WritingOptions
    ) throws
}

struct FoundationPendingLocationDataWriter: PendingLocationDataWriting {
    func write(
        _ data: Data,
        to fileURL: URL,
        options: Data.WritingOptions
    ) throws {
        try data.write(to: fileURL, options: options)
    }
}

final class AtomicFilePendingLocationRecordStorage: PendingLocationRecordStorage {
    private let fileManager: FileManager
    private let fileURL: URL?
    private let dataWriter: PendingLocationDataWriting

    init(
        fileManager: FileManager = .default,
        fileURL: URL? = AtomicFilePendingLocationRecordStorage.defaultFileURL(),
        dataWriter: PendingLocationDataWriting = FoundationPendingLocationDataWriter()
    ) {
        self.fileManager = fileManager
        self.fileURL = fileURL
        self.dataWriter = dataWriter
    }

    func read() -> PendingLocationRecordStorageReadResult {
        guard let fileURL else {
            return .failure
        }
        guard fileManager.fileExists(atPath: fileURL.path) else {
            return .missing
        }
        do {
            return .data(try Data(contentsOf: fileURL))
        } catch {
            return .failure
        }
    }

    func write(_ data: Data) -> Bool {
        guard let fileURL else {
            return false
        }
        let previousData: Data?
        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                previousData = try Data(contentsOf: fileURL)
            } catch {
                return false
            }
        } else {
            previousData = nil
        }

        do {
            try fileManager.createDirectory(
                at: fileURL.deletingLastPathComponent(),
                withIntermediateDirectories: true
            )
            try dataWriter.write(
                data,
                to: fileURL,
                options: writingOptions
            )
            try synchronizeFile(at: fileURL)
            try synchronizeDirectory(at: fileURL.deletingLastPathComponent())
            return true
        } catch {
            restore(previousData, at: fileURL)
            return false
        }
    }

    func remove() -> Bool {
        guard let fileURL else {
            return false
        }
        guard fileManager.fileExists(atPath: fileURL.path) else {
            return true
        }
        let previousData: Data
        do {
            previousData = try Data(contentsOf: fileURL)
        } catch {
            return false
        }

        do {
            try fileManager.removeItem(at: fileURL)
            try synchronizeDirectory(at: fileURL.deletingLastPathComponent())
            return true
        } catch {
            restore(previousData, at: fileURL)
            return false
        }
    }

    private static func defaultFileURL() -> URL? {
        FileManager.default.urls(
            for: .applicationSupportDirectory,
            in: .userDomainMask
        ).first?
            .appendingPathComponent(
                "net.yumnumm.background_location_tracker",
                isDirectory: true
            )
            .appendingPathComponent("pending_location_v2.plist")
    }

    private func synchronizeFile(at fileURL: URL) throws {
        let handle = try FileHandle(forWritingTo: fileURL)
        try handle.synchronize()
        try handle.close()
    }

    private func synchronizeDirectory(at directoryURL: URL) throws {
        let descriptor = Darwin.open(directoryURL.path, O_RDONLY)
        guard descriptor >= 0 else {
            throw AtomicFileStorageError.posix(errno)
        }
        defer { Darwin.close(descriptor) }
        guard Darwin.fsync(descriptor) == 0 else {
            throw AtomicFileStorageError.posix(errno)
        }
    }

    private func restore(_ data: Data?, at fileURL: URL) {
        do {
            if let data {
                try dataWriter.write(
                    data,
                    to: fileURL,
                    options: writingOptions
                )
                try synchronizeFile(at: fileURL)
            } else if fileManager.fileExists(atPath: fileURL.path) {
                try fileManager.removeItem(at: fileURL)
            }
            try synchronizeDirectory(at: fileURL.deletingLastPathComponent())
        } catch {
            // 呼出元へ失敗を返す。次回readでは残存recordを再検証する。
        }
    }

    private var writingOptions: Data.WritingOptions {
        // 初回unlock後のbackground relaunchでは、端末lock中でもpendingを更新できる必要がある。
        [.atomic, .completeFileProtectionUntilFirstUserAuthentication]
    }
}

private enum AtomicFileStorageError: Error {
    case posix(Int32)
}

private struct PendingLocationRecord: Codable, Equatable {
    let schemaVersion: Int
    let updateId: String
    let latitude: Double
    let longitude: Double
    let accuracy: Double
    let timestampMillis: Int64
    let deviceLocationPending: Bool
    let appEffectsPending: Bool

    var location: StoredPendingLocation {
        StoredPendingLocation(
            updateId: updateId,
            latitude: latitude,
            longitude: longitude,
            accuracy: accuracy,
            timestampMillis: timestampMillis
        )
    }

    var hasPendingConsumer: Bool {
        deviceLocationPending || appEffectsPending
    }

    var isValid: Bool {
        schemaVersion == 1
            && !updateId.isEmpty
            && latitude.isFinite
            && longitude.isFinite
            && accuracy.isFinite
            && timestampMillis > 0
    }

    func isPending(consumer: PendingLocationStore.Consumer) -> Bool {
        switch consumer {
        case .deviceLocation:
            deviceLocationPending
        case .appEffects:
            appEffectsPending
        }
    }

    func acknowledging(consumer: PendingLocationStore.Consumer) -> Self {
        switch consumer {
        case .deviceLocation:
            Self(
                schemaVersion: schemaVersion,
                updateId: updateId,
                latitude: latitude,
                longitude: longitude,
                accuracy: accuracy,
                timestampMillis: timestampMillis,
                deviceLocationPending: false,
                appEffectsPending: appEffectsPending
            )
        case .appEffects:
            Self(
                schemaVersion: schemaVersion,
                updateId: updateId,
                latitude: latitude,
                longitude: longitude,
                accuracy: accuracy,
                timestampMillis: timestampMillis,
                deviceLocationPending: deviceLocationPending,
                appEffectsPending: false
            )
        }
    }
}

final class PendingLocationStore {
    enum Consumer {
        case deviceLocation
        case appEffects
    }

    private static let lock = NSLock()

    private let storage: PendingLocationRecordStorage
    private let legacyUserDefaults: UserDefaults
    private let updateIdProvider: () -> String
    private let encoder = PropertyListEncoder()
    private let decoder = PropertyListDecoder()

    init(
        storage: PendingLocationRecordStorage = AtomicFilePendingLocationRecordStorage(),
        legacyUserDefaults: UserDefaults = .standard,
        updateIdProvider: @escaping () -> String = { UUID().uuidString }
    ) {
        self.storage = storage
        self.legacyUserDefaults = legacyUserDefaults
        self.updateIdProvider = updateIdProvider
        encoder.outputFormat = .binary
    }

    func save(
        latitude: Double,
        longitude: Double,
        accuracy: Double,
        timestampMillis: Int64
    ) -> StoredPendingLocation? {
        Self.lock.lock()
        defer { Self.lock.unlock() }

        let record = PendingLocationRecord(
            schemaVersion: 1,
            updateId: updateIdProvider(),
            latitude: latitude,
            longitude: longitude,
            accuracy: accuracy,
            timestampMillis: timestampMillis,
            deviceLocationPending: true,
            appEffectsPending: true
        )
        guard record.isValid, write(record) else {
            return nil
        }
        cleanupLegacyRecords()
        return record.location
    }

    func peek(consumer: Consumer) -> StoredPendingLocation? {
        Self.lock.lock()
        defer { Self.lock.unlock() }

        guard let record = readOrMigrateRecord(), record.isPending(consumer: consumer) else {
            return nil
        }
        return record.location
    }

    func acknowledge(updateId: String, consumer: Consumer) -> Bool {
        Self.lock.lock()
        defer { Self.lock.unlock() }

        guard let record = readOrMigrateRecord(),
              record.updateId == updateId,
              record.isPending(consumer: consumer)
        else {
            return false
        }
        let updatedRecord = record.acknowledging(consumer: consumer)
        if updatedRecord.hasPendingConsumer {
            return write(updatedRecord)
        }
        return storage.remove()
    }

    private func readOrMigrateRecord() -> PendingLocationRecord? {
        switch storage.read() {
        case .data(let data):
            guard let record = try? decoder.decode(PendingLocationRecord.self, from: data),
                  record.isValid,
                  record.hasPendingConsumer
            else {
                _ = storage.remove()
                return nil
            }
            cleanupLegacyRecords()
            return record
        case .failure:
            return nil
        case .missing:
            return migrateRoundZeroRecord() ?? migrateLegacyRecord()
        }
    }

    private func migrateRoundZeroRecord() -> PendingLocationRecord? {
        guard roundZeroKeys.contains(where: {
            legacyUserDefaults.object(forKey: $0) != nil
        }) else {
            return nil
        }
        guard roundZeroKeys.allSatisfy({ legacyUserDefaults.object(forKey: $0) != nil }),
              let updateId = legacyUserDefaults.string(
                  forKey: BackgroundLocationStorageKey.roundZeroUpdateId
              ),
              let latitude = legacyUserDefaults.object(
                  forKey: BackgroundLocationStorageKey.roundZeroLatitude
              ) as? Double,
              let longitude = legacyUserDefaults.object(
                  forKey: BackgroundLocationStorageKey.roundZeroLongitude
              ) as? Double,
              let accuracy = legacyUserDefaults.object(
                  forKey: BackgroundLocationStorageKey.roundZeroAccuracy
              ) as? Double,
              let timestamp = legacyUserDefaults.object(
                  forKey: BackgroundLocationStorageKey.roundZeroTimestampMillis
              ) as? NSNumber
        else {
            cleanup(keys: roundZeroKeys)
            return nil
        }
        let record = PendingLocationRecord(
            schemaVersion: 1,
            updateId: updateId,
            latitude: latitude,
            longitude: longitude,
            accuracy: accuracy,
            timestampMillis: timestamp.int64Value,
            deviceLocationPending: legacyUserDefaults.bool(
                forKey: BackgroundLocationStorageKey.roundZeroDeviceLocationPending
            ),
            appEffectsPending: legacyUserDefaults.bool(
                forKey: BackgroundLocationStorageKey.roundZeroAppEffectsPending
            )
        )
        guard record.isValid, record.hasPendingConsumer else {
            cleanup(keys: roundZeroKeys)
            return nil
        }
        guard write(record) else {
            return nil
        }
        cleanup(keys: roundZeroKeys)
        return record
    }

    private func migrateLegacyRecord() -> PendingLocationRecord? {
        guard legacyKeys.contains(where: {
            legacyUserDefaults.object(forKey: $0) != nil
        }) else {
            return nil
        }
        guard let latitude = legacyUserDefaults.object(
            forKey: BackgroundLocationStorageKey.legacyLatitude
        ) as? Double,
            let longitude = legacyUserDefaults.object(
                forKey: BackgroundLocationStorageKey.legacyLongitude
            ) as? Double,
            let timestampSeconds = legacyUserDefaults.object(
                forKey: BackgroundLocationStorageKey.legacyTimestampSeconds
            ) as? Double
        else {
            cleanup(keys: legacyKeys)
            return nil
        }
        let timestampMillisDouble = (timestampSeconds * 1000).rounded()
        guard timestampMillisDouble.isFinite,
              timestampMillisDouble > 0,
              timestampMillisDouble <= Double(Int64.max)
        else {
            cleanup(keys: legacyKeys)
            return nil
        }
        let record = PendingLocationRecord(
            schemaVersion: 1,
            updateId: updateIdProvider(),
            latitude: latitude,
            longitude: longitude,
            accuracy: 0,
            timestampMillis: Int64(timestampMillisDouble),
            deviceLocationPending: true,
            appEffectsPending: true
        )
        guard record.isValid else {
            cleanup(keys: legacyKeys)
            return nil
        }
        guard write(record) else {
            return nil
        }
        cleanup(keys: legacyKeys)
        return record
    }

    private func write(_ record: PendingLocationRecord) -> Bool {
        guard let data = try? encoder.encode(record) else {
            return false
        }
        return storage.write(data)
    }

    private func cleanupLegacyRecords() {
        cleanup(keys: roundZeroKeys + legacyKeys)
    }

    private func cleanup(keys: [String]) {
        guard keys.contains(where: {
            legacyUserDefaults.object(forKey: $0) != nil
        }) else {
            return
        }
        keys.forEach(legacyUserDefaults.removeObject(forKey:))
        legacyUserDefaults.synchronize()
    }

    private let legacyKeys = [
        BackgroundLocationStorageKey.legacyLatitude,
        BackgroundLocationStorageKey.legacyLongitude,
        BackgroundLocationStorageKey.legacyTimestampSeconds,
    ]

    private let roundZeroKeys = [
        BackgroundLocationStorageKey.roundZeroUpdateId,
        BackgroundLocationStorageKey.roundZeroLatitude,
        BackgroundLocationStorageKey.roundZeroLongitude,
        BackgroundLocationStorageKey.roundZeroAccuracy,
        BackgroundLocationStorageKey.roundZeroTimestampMillis,
        BackgroundLocationStorageKey.roundZeroDeviceLocationPending,
        BackgroundLocationStorageKey.roundZeroAppEffectsPending,
    ]
}
