import Foundation
import Testing

struct BackgroundLocationPendingLocationStoreTests {
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
}

private final class StoreFixture {
    let store: PendingLocationStore

    private let defaults: UserDefaults
    private let suiteName: String

    init(updateId: String) throws {
        suiteName = "BackgroundLocationPendingLocationStoreTests.\(UUID().uuidString)"
        defaults = try #require(UserDefaults(suiteName: suiteName))
        defaults.removePersistentDomain(forName: suiteName)
        store = PendingLocationStore(
            userDefaults: defaults,
            updateIdProvider: { updateId }
        )
    }

    deinit {
        defaults.removePersistentDomain(forName: suiteName)
    }
}
