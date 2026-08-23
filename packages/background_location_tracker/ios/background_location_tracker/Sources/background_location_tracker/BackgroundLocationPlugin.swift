import Flutter
import Foundation

public final class BackgroundLocationPlugin: NSObject, FlutterPlugin,
    BackgroundLocationHostApi
{
    private var flutterApi: BackgroundLocationFlutterApi?
    private let monitor = SignificantLocationMonitor()
    private let pendingStore = PendingLocationStore()

    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = BackgroundLocationPlugin()
        instance.flutterApi = BackgroundLocationFlutterApi(
            binaryMessenger: registrar.messenger()
        )
        BackgroundLocationHostApiSetup.setUp(
            binaryMessenger: registrar.messenger(),
            api: instance
        )
        instance.monitor.onLocationUpdate = { [weak instance] lat, lon, acc, timestamp in
            guard let instance,
                  let stored = instance.pendingStore.save(
                      latitude: lat,
                      longitude: lon,
                      accuracy: acc,
                      timestampMillis: timestamp
                  )
            else {
                return
            }
            instance.flutterApi?.onLocationUpdate(location: stored.pigeonMessage) { _ in }
        }
    }

    public func initialize(callbackHandle: Int64) throws {
        UserDefaults.standard.set(
            callbackHandle,
            forKey: BackgroundLocationStorageKey.callbackHandle
        )
    }

    public func startMonitoring() throws {
        monitor.start()
    }

    public func stopMonitoring() throws {
        monitor.stop()
    }

    func peekPendingLocation(
        consumer: PendingLocationConsumer
    ) throws -> PendingLocationMessage? {
        pendingStore.peek(consumer: consumer.storeConsumer)?.pigeonMessage
    }

    func acknowledgePendingLocation(
        updateId: String,
        consumer: PendingLocationConsumer
    ) throws -> Bool {
        pendingStore.acknowledge(
            updateId: updateId,
            consumer: consumer.storeConsumer
        )
    }

    func getActiveHeadlessTaskId() throws -> String? {
        LocationHeadlessRunner.shared.activeUpdateId
    }

    func completeHeadlessTask(
        updateId: String,
        result: HeadlessTaskResult
    ) throws {
        LocationHeadlessRunner.shared.complete(
            updateId: updateId,
            result: result
        )
    }
}

private extension PendingLocationConsumer {
    var storeConsumer: PendingLocationStore.Consumer {
        switch self {
        case .deviceLocation:
            .deviceLocation
        case .appEffects:
            .appEffects
        }
    }
}

private extension StoredPendingLocation {
    var pigeonMessage: PendingLocationMessage {
        PendingLocationMessage(
            updateId: updateId,
            latitude: latitude,
            longitude: longitude,
            accuracy: accuracy,
            timestampMillis: timestampMillis
        )
    }
}
