import Foundation
import Testing

struct BackgroundLocationPendingLocationStoreTests {
    @Test func atomicFileStorageUsesAfterFirstUnlockProtectionForCreatedAndReplacedFile() throws {
        let directoryURL = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString, isDirectory: true)
        defer { try? FileManager.default.removeItem(at: directoryURL) }
        let fileURL = directoryURL.appendingPathComponent("pending.plist")
        let storage = AtomicFilePendingLocationRecordStorage(fileURL: fileURL)

        #expect(storage.write(Data([0x01, 0x02])))
        let createdProtection = try fileProtectionType(at: fileURL)
        #expect(createdProtection == .completeUntilFirstUserAuthentication)
        #expect(try isExcludedFromBackup(at: directoryURL))
        #expect(try isExcludedFromBackup(at: fileURL))

        #expect(storage.write(Data([0x03, 0x04])))
        let replacedProtection = try fileProtectionType(at: fileURL)
        #expect(replacedProtection == .completeUntilFirstUserAuthentication)
        #expect(try isExcludedFromBackup(at: directoryURL))
        #expect(try isExcludedFromBackup(at: fileURL))
    }

    @Test func failedAtomicWriteRestoresPreviousDataWithAfterFirstUnlockProtection() throws {
        let directoryURL = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString, isDirectory: true)
        defer { try? FileManager.default.removeItem(at: directoryURL) }
        try FileManager.default.createDirectory(
            at: directoryURL,
            withIntermediateDirectories: true
        )
        let fileURL = directoryURL.appendingPathComponent("pending.plist")
        let previousData = Data([0x01, 0x02])
        try previousData.write(
            to: fileURL,
            options: [.atomic, .completeFileProtectionUntilFirstUserAuthentication]
        )
        let dataWriter = FailingOncePendingLocationDataWriter()
        let storage = AtomicFilePendingLocationRecordStorage(
            fileURL: fileURL,
            dataWriter: dataWriter
        )

        #expect(storage.write(Data([0x03, 0x04])) == false)
        #expect(try Data(contentsOf: fileURL) == previousData)
        #expect(dataWriter.writingOptions == [
            [.atomic, .completeFileProtectionUntilFirstUserAuthentication],
            [.atomic, .completeFileProtectionUntilFirstUserAuthentication],
        ])
        let restoredProtection = try fileProtectionType(at: fileURL)
        #expect(restoredProtection == .completeUntilFirstUserAuthentication)
        #expect(try isExcludedFromBackup(at: directoryURL))
        #expect(try isExcludedFromBackup(at: fileURL))
    }

    @Test func atomicFileStorageReplacesAndRemovesOneSerializedRecord() throws {
        let directoryURL = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString, isDirectory: true)
        defer { try? FileManager.default.removeItem(at: directoryURL) }
        let storage = AtomicFilePendingLocationRecordStorage(
            fileURL: directoryURL.appendingPathComponent("pending.plist")
        )
        let firstData = Data([0x01, 0x02])
        let secondData = Data([0x03, 0x04])

        #expect(storage.write(firstData))
        #expect(storage.read().data == firstData)
        #expect(storage.write(secondData))
        #expect(storage.read().data == secondData)
        #expect(storage.remove())
        #expect(storage.read().isMissing)
    }

    @Test func legacyLocationMigratesWithMillisecondsAndBothConsumersPending() throws {
        let fixture = try StoreFixture(updateId: "migrated-id")
        fixture.defaults.set(35.0, forKey: "blt_pending_lat")
        fixture.defaults.set(139.0, forKey: "blt_pending_lon")
        fixture.defaults.set(1234.567, forKey: "blt_pending_ts")

        let migrated = try #require(fixture.store.peek(consumer: .deviceLocation))

        #expect(migrated.updateId == "migrated-id")
        #expect(migrated.latitude == 35)
        #expect(migrated.longitude == 139)
        #expect(migrated.accuracy == 0)
        #expect(migrated.timestampMillis == 1_234_567)
        #expect(fixture.store.peek(consumer: .appEffects)?.updateId == "migrated-id")
        #expect(fixture.defaults.object(forKey: "blt_pending_lat") == nil)
        #expect(fixture.defaults.object(forKey: "blt_pending_lon") == nil)
        #expect(fixture.defaults.object(forKey: "blt_pending_ts") == nil)
    }

    @Test func failedLegacyMigrationKeepsLegacyLocationForRetry() throws {
        let fixture = try StoreFixture(updateIds: ["failed-id", "migrated-id"])
        fixture.defaults.set(36.0, forKey: "blt_pending_lat")
        fixture.defaults.set(140.0, forKey: "blt_pending_lon")
        fixture.defaults.set(2345.678, forKey: "blt_pending_ts")
        fixture.storage.failNextWrite = true

        #expect(fixture.store.peek(consumer: .deviceLocation) == nil)
        #expect(fixture.defaults.object(forKey: "blt_pending_lat") != nil)
        #expect(fixture.defaults.object(forKey: "blt_pending_lon") != nil)
        #expect(fixture.defaults.object(forKey: "blt_pending_ts") != nil)

        #expect(fixture.store.peek(consumer: .deviceLocation)?.updateId == "migrated-id")
    }

    @Test func incompleteLegacyLocationRemovesRawCoordinateKeys() throws {
        let fixture = try StoreFixture(updateId: "unused-id")
        fixture.defaults.set(35.0, forKey: "blt_pending_lat")
        fixture.defaults.set(1234.567, forKey: "blt_pending_ts")

        #expect(fixture.store.peek(consumer: .deviceLocation) == nil)
        #expect(fixture.defaults.object(forKey: "blt_pending_lat") == nil)
        #expect(fixture.defaults.object(forKey: "blt_pending_lon") == nil)
        #expect(fixture.defaults.object(forKey: "blt_pending_ts") == nil)
    }

    @Test func staleAcknowledgeKeepsTheLatestLocation() throws {
        let fixture = try StoreFixture(updateId: "new-id")
        let stored = try #require(
            fixture.store.save(
                latitude: 35,
                longitude: 139,
                accuracy: 10,
                timestampMillis: 1000
            )
        )

        #expect(stored.updateId == "new-id")
        #expect(
            fixture.store.acknowledge(
                updateId: "older-id",
                consumer: .deviceLocation
            ) == false
        )
        #expect(fixture.store.peek(consumer: .deviceLocation)?.updateId == "new-id")
    }

    @Test func locationRemainsUntilBothConsumersAcknowledge() throws {
        let fixture = try StoreFixture(updateId: "new-id")
        let stored = try #require(
            fixture.store.save(
                latitude: 36,
                longitude: 140,
                accuracy: 20,
                timestampMillis: 2000
            )
        )

        #expect(
            fixture.store.acknowledge(
                updateId: stored.updateId,
                consumer: .deviceLocation
            )
        )
        #expect(fixture.store.peek(consumer: .deviceLocation) == nil)
        #expect(fixture.store.peek(consumer: .appEffects)?.updateId == stored.updateId)

        #expect(
            fixture.store.acknowledge(
                updateId: stored.updateId,
                consumer: .appEffects
            )
        )
        #expect(fixture.store.peek(consumer: .appEffects) == nil)
    }

    @Test func failedSaveKeepsThePreviousCompleteLocation() throws {
        let fixture = try StoreFixture(updateIds: ["previous-id", "new-id"])
        _ = try #require(
            fixture.store.save(
                latitude: 35,
                longitude: 139,
                accuracy: 10,
                timestampMillis: 1000
            )
        )
        fixture.storage.failNextWrite = true

        #expect(
            fixture.store.save(
                latitude: 36,
                longitude: 140,
                accuracy: 20,
                timestampMillis: 2000
            ) == nil
        )
        #expect(fixture.store.peek(consumer: .deviceLocation)?.updateId == "previous-id")
        #expect(fixture.store.peek(consumer: .appEffects)?.updateId == "previous-id")
    }

    @Test func failedDeviceLocationAcknowledgeKeepsBothConsumersPending() throws {
        let fixture = try StoreFixture(updateId: "pending-id")
        _ = try #require(
            fixture.store.save(
                latitude: 35,
                longitude: 139,
                accuracy: 10,
                timestampMillis: 1000
            )
        )
        fixture.storage.failNextWrite = true

        #expect(
            fixture.store.acknowledge(
                updateId: "pending-id",
                consumer: .deviceLocation
            ) == false
        )
        #expect(fixture.store.peek(consumer: .deviceLocation)?.updateId == "pending-id")
        #expect(fixture.store.peek(consumer: .appEffects)?.updateId == "pending-id")
    }

    @Test func failedFinalAppEffectsAcknowledgeKeepsThePendingLocation() throws {
        let fixture = try StoreFixture(updateId: "pending-id")
        _ = try #require(
            fixture.store.save(
                latitude: 35,
                longitude: 139,
                accuracy: 10,
                timestampMillis: 1000
            )
        )
        #expect(
            fixture.store.acknowledge(
                updateId: "pending-id",
                consumer: .deviceLocation
            )
        )
        fixture.storage.failNextRemove = true

        #expect(
            fixture.store.acknowledge(
                updateId: "pending-id",
                consumer: .appEffects
            ) == false
        )
        #expect(fixture.store.peek(consumer: .deviceLocation) == nil)
        #expect(fixture.store.peek(consumer: .appEffects)?.updateId == "pending-id")
    }

    @Test func incompleteSerializedRecordIsRemoved() throws {
        let fixture = try StoreFixture(updateId: "unused-id")
        fixture.storage.data = Data([0x00, 0x01, 0x02])

        #expect(fixture.store.peek(consumer: .deviceLocation) == nil)
        #expect(fixture.storage.data == nil)
    }

}

private func fileProtectionType(at fileURL: URL) throws -> URLFileProtection? {
    try fileURL.resourceValues(forKeys: [.fileProtectionKey]).fileProtection
}

private func isExcludedFromBackup(at url: URL) throws -> Bool {
    try url.resourceValues(forKeys: [.isExcludedFromBackupKey]).isExcludedFromBackup ?? false
}

private final class FailingOncePendingLocationDataWriter: PendingLocationDataWriting {
    private(set) var writingOptions: [Data.WritingOptions] = []
    private var shouldFail = true

    func write(
        _ data: Data,
        to fileURL: URL,
        options: Data.WritingOptions
    ) throws {
        writingOptions.append(options)
        if shouldFail {
            shouldFail = false
            throw TestDataWriterError.injectedFailure
        }
        try data.write(to: fileURL, options: options)
    }
}

private enum TestDataWriterError: Error {
    case injectedFailure
}

private extension PendingLocationRecordStorageReadResult {
    var data: Data? {
        if case .data(let data) = self {
            return data
        }
        return nil
    }

    var isMissing: Bool {
        if case .missing = self {
            return true
        }
        return false
    }
}

private final class StoreFixture {
    let store: PendingLocationStore
    let storage = FakePendingLocationRecordStorage()

    let defaults: UserDefaults
    private let suiteName: String

    convenience init(updateId: String) throws {
        try self.init(updateIds: [updateId])
    }

    init(updateIds: [String]) throws {
        suiteName = "BackgroundLocationPendingLocationStoreTests.\(UUID().uuidString)"
        defaults = try #require(UserDefaults(suiteName: suiteName))
        defaults.removePersistentDomain(forName: suiteName)
        var remainingUpdateIds = updateIds
        store = PendingLocationStore(
            storage: storage,
            legacyUserDefaults: defaults,
            updateIdProvider: { remainingUpdateIds.removeFirst() }
        )
    }

    deinit {
        defaults.removePersistentDomain(forName: suiteName)
    }
}

private final class FakePendingLocationRecordStorage: PendingLocationRecordStorage {
    var data: Data?
    var failNextWrite = false
    var failNextRemove = false

    func read() -> PendingLocationRecordStorageReadResult {
        if let data {
            return .data(data)
        }
        return .missing
    }

    func write(_ newData: Data) -> Bool {
        if failNextWrite {
            failNextWrite = false
            return false
        }
        data = newData
        return true
    }

    func remove() -> Bool {
        if failNextRemove {
            failNextRemove = false
            return false
        }
        data = nil
        return true
    }
}
