import Foundation

enum BackgroundLocationStorageKey {
    static let callbackHandle = "blt_callback_handle"
    static let updateId = "blt_pending_update_id"
    static let latitude = "blt_pending_latitude"
    static let longitude = "blt_pending_longitude"
    static let accuracy = "blt_pending_accuracy"
    static let timestampMillis = "blt_pending_timestamp_millis"
    static let deviceLocationPending = "blt_pending_device_location"
    static let appEffectsPending = "blt_pending_app_effects"
}

struct StoredPendingLocation: Equatable {
    let updateId: String
    let latitude: Double
    let longitude: Double
    let accuracy: Double
    let timestampMillis: Int64
}

final class PendingLocationStore {
    enum Consumer {
        case deviceLocation
        case appEffects
    }

    private static let lock = NSLock()

    private let userDefaults: UserDefaults
    private let updateIdProvider: () -> String

    init(
        userDefaults: UserDefaults = .standard,
        updateIdProvider: @escaping () -> String = { UUID().uuidString }
    ) {
        self.userDefaults = userDefaults
        self.updateIdProvider = updateIdProvider
    }

    func save(
        latitude: Double,
        longitude: Double,
        accuracy: Double,
        timestampMillis: Int64
    ) -> StoredPendingLocation? {
        Self.lock.lock()
        defer { Self.lock.unlock() }

        let location = StoredPendingLocation(
            updateId: updateIdProvider(),
            latitude: latitude,
            longitude: longitude,
            accuracy: accuracy,
            timestampMillis: timestampMillis
        )
        userDefaults.set(location.updateId, forKey: BackgroundLocationStorageKey.updateId)
        userDefaults.set(location.latitude, forKey: BackgroundLocationStorageKey.latitude)
        userDefaults.set(location.longitude, forKey: BackgroundLocationStorageKey.longitude)
        userDefaults.set(location.accuracy, forKey: BackgroundLocationStorageKey.accuracy)
        userDefaults.set(
            location.timestampMillis,
            forKey: BackgroundLocationStorageKey.timestampMillis
        )
        userDefaults.set(true, forKey: BackgroundLocationStorageKey.deviceLocationPending)
        userDefaults.set(true, forKey: BackgroundLocationStorageKey.appEffectsPending)

        guard readLocation() == location,
              userDefaults.bool(forKey: BackgroundLocationStorageKey.deviceLocationPending),
              userDefaults.bool(forKey: BackgroundLocationStorageKey.appEffectsPending)
        else {
            clearLocation()
            return nil
        }
        return location
    }

    func peek(consumer: Consumer) -> StoredPendingLocation? {
        Self.lock.lock()
        defer { Self.lock.unlock() }

        guard userDefaults.bool(forKey: pendingKey(for: consumer)) else {
            return nil
        }
        return readLocation()
    }

    func acknowledge(updateId: String, consumer: Consumer) -> Bool {
        Self.lock.lock()
        defer { Self.lock.unlock() }

        guard readLocation()?.updateId == updateId,
              userDefaults.bool(forKey: pendingKey(for: consumer))
        else {
            return false
        }
        userDefaults.set(false, forKey: pendingKey(for: consumer))
        if allConsumersAcknowledged {
            clearLocation()
            return readLocation() == nil
        }
        return !userDefaults.bool(forKey: pendingKey(for: consumer))
    }

    private var allConsumersAcknowledged: Bool {
        !userDefaults.bool(forKey: BackgroundLocationStorageKey.deviceLocationPending)
            && !userDefaults.bool(forKey: BackgroundLocationStorageKey.appEffectsPending)
    }

    private func pendingKey(for consumer: Consumer) -> String {
        switch consumer {
        case .deviceLocation:
            BackgroundLocationStorageKey.deviceLocationPending
        case .appEffects:
            BackgroundLocationStorageKey.appEffectsPending
        }
    }

    private func readLocation() -> StoredPendingLocation? {
        guard let updateId = userDefaults.string(forKey: BackgroundLocationStorageKey.updateId),
              let latitude = userDefaults.object(
                  forKey: BackgroundLocationStorageKey.latitude
              ) as? Double,
              let longitude = userDefaults.object(
                  forKey: BackgroundLocationStorageKey.longitude
              ) as? Double,
              let accuracy = userDefaults.object(
                  forKey: BackgroundLocationStorageKey.accuracy
              ) as? Double,
              let timestamp = userDefaults.object(
                  forKey: BackgroundLocationStorageKey.timestampMillis
              ) as? NSNumber
        else {
            return nil
        }
        return StoredPendingLocation(
            updateId: updateId,
            latitude: latitude,
            longitude: longitude,
            accuracy: accuracy,
            timestampMillis: timestamp.int64Value
        )
    }

    private func clearLocation() {
        let keys = [
            BackgroundLocationStorageKey.updateId,
            BackgroundLocationStorageKey.latitude,
            BackgroundLocationStorageKey.longitude,
            BackgroundLocationStorageKey.accuracy,
            BackgroundLocationStorageKey.timestampMillis,
            BackgroundLocationStorageKey.deviceLocationPending,
            BackgroundLocationStorageKey.appEffectsPending,
        ]
        keys.forEach(userDefaults.removeObject(forKey:))
    }
}
