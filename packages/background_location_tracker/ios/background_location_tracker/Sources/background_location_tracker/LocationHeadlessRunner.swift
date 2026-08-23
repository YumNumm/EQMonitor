import BackgroundTasks
import CoreLocation
import Flutter
import Foundation
import UIKit

public typealias PluginRegistrantCallback = (FlutterEngine) -> Void

/// Significant Location ChangeとOS retry taskからDartのheadless処理を起動する。
public final class LocationHeadlessRunner: NSObject, CLLocationManagerDelegate {
    public static let shared = LocationHeadlessRunner()

    public static var pluginRegistrantCallback: PluginRegistrantCallback?

    private static let appRefreshTaskIdentifier =
        "net.yumnumm.eqmonitor.background-location-refresh"
    private static let processingTaskIdentifier =
        "net.yumnumm.eqmonitor.background-location-processing"

    private let pendingStore = PendingLocationStore()
    private let taskState = HeadlessTaskState()
    private var headlessEngine: FlutterEngine?
    private var activeSystemTask: HeadlessSystemTask?
    private var locationManager: CLLocationManager?
    private var hasStartedLocationRelaunch = false
    private var hasRegisteredRetryTasks = false

    override private init() {}

    public var activeUpdateId: String? {
        taskState.activeUpdateId
    }

    public func registerRetryTaskHandlers() {
        guard !hasRegisteredRetryTasks else { return }
        hasRegisteredRetryTasks = true

        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: Self.appRefreshTaskIdentifier,
            using: .main
        ) { [weak self] task in
            self?.startFromScheduledRetry(task: task)
        }
        BGTaskScheduler.shared.register(
            forTaskWithIdentifier: Self.processingTaskIdentifier,
            using: .main
        ) { [weak self] task in
            self?.startFromScheduledRetry(task: task)
        }
    }

    /// `.location` launch optionを受け取った後に監視を復元する。
    public func startFromLaunchOptions() {
        guard !hasStartedLocationRelaunch else { return }
        hasStartedLocationRelaunch = true

        let manager = CLLocationManager()
        manager.delegate = self
        locationManager = manager
        manager.startMonitoringSignificantLocationChanges()
    }

    public func start(
        latitude: Double,
        longitude: Double,
        accuracy: Double,
        timestampMillis: Int64
    ) {
        guard let stored = pendingStore.save(
            latitude: latitude,
            longitude: longitude,
            accuracy: accuracy,
            timestampMillis: timestampMillis
        ) else {
            return
        }
        startStored(updateId: stored.updateId, scheduledTask: nil)
    }

    func complete(
        updateId: String,
        result: HeadlessTaskResult
    ) {
        let completionResult: HeadlessTaskCompletionResult = switch result {
        case .success:
            .success
        case .retry:
            .retry
        case .terminalFailure:
            .terminalFailure
        }
        guard let effect = taskState.complete(
            updateId: updateId,
            result: completionResult
        ) else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.finish(updateId: updateId, effect: effect)
        }
    }

    public func locationManager(
        _: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else { return }
        start(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude,
            accuracy: location.horizontalAccuracy,
            timestampMillis: Int64(location.timestamp.timeIntervalSince1970 * 1000)
        )
    }

    public func locationManager(
        _: CLLocationManager,
        didFailWithError _: Error
    ) {}

    private var storedCallbackInformation: FlutterCallbackInformation? {
        let storedValue = UserDefaults.standard.object(
            forKey: BackgroundLocationStorageKey.callbackHandle
        )
        let callbackHandle: Int64?
        switch storedValue {
        case let value as Int64:
            callbackHandle = value
        case let value as Int:
            callbackHandle = Int64(value)
        default:
            callbackHandle = nil
        }
        guard let callbackHandle else { return nil }
        return FlutterCallbackCache.lookupCallbackInformation(callbackHandle)
    }

    private func startFromScheduledRetry(task: BGTask) {
        guard let pending = pendingStore.peek(consumer: .deviceLocation) else {
            task.setTaskCompleted(success: true)
            return
        }
        startStored(updateId: pending.updateId, scheduledTask: task)
    }

    private func startStored(updateId: String, scheduledTask: BGTask?) {
        guard taskState.begin(updateId: updateId) == .launch else {
            scheduledTask?.setTaskCompleted(success: false)
            scheduleRetry()
            return
        }

        if let scheduledTask {
            activeSystemTask = ScheduledBackgroundTask(task: scheduledTask)
            scheduledTask.expirationHandler = { [weak self] in
                self?.expire(updateId: updateId)
            }
        } else {
            activeSystemTask = ApplicationBackgroundTask(
                updateId: updateId,
                expirationHandler: { [weak self] in
                    self?.expire(updateId: updateId)
                }
            )
        }

        guard let callbackInformation = storedCallbackInformation,
              let registrant = Self.pluginRegistrantCallback
        else {
            requestRetryCompletion(updateId: updateId)
            return
        }

        let engine = FlutterEngine(
            name: "blt_headless",
            project: nil,
            allowHeadlessExecution: true
        )
        headlessEngine = engine
        guard engine.run(
            withEntrypoint: callbackInformation.callbackName,
            libraryURI: callbackInformation.callbackLibraryPath
        ) else {
            requestRetryCompletion(updateId: updateId)
            return
        }
        registrant(engine)
    }

    private func requestRetryCompletion(updateId: String) {
        guard let effect = taskState.complete(
            updateId: updateId,
            result: .retry
        ) else {
            return
        }
        finish(updateId: updateId, effect: effect)
    }

    private func expire(updateId: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self,
                  let effect = taskState.expire(updateId: updateId)
            else {
                return
            }
            finish(updateId: updateId, effect: effect)
        }
    }

    private func finish(
        updateId: String,
        effect: HeadlessTaskFinishEffect
    ) {
        guard let finalization = taskState.finalize(updateId: updateId) else {
            return
        }

        let engine = headlessEngine
        headlessEngine = nil
        engine?.destroyContext()

        let systemTask = activeSystemTask
        activeSystemTask = nil
        systemTask?.complete(success: effect.backgroundTaskSucceeded)

        if effect.shouldScheduleRetry {
            scheduleRetry()
        } else if let nextUpdateId = finalization.nextUpdateId {
            startStored(updateId: nextUpdateId, scheduledTask: nil)
        }
    }

    private func scheduleRetry() {
        let refreshRequest = BGAppRefreshTaskRequest(
            identifier: Self.appRefreshTaskIdentifier
        )
        let processingRequest = BGProcessingTaskRequest(
            identifier: Self.processingTaskIdentifier
        )
        processingRequest.requiresNetworkConnectivity = true
        processingRequest.requiresExternalPower = false
        try? BGTaskScheduler.shared.submit(refreshRequest)
        try? BGTaskScheduler.shared.submit(processingRequest)
    }
}

private protocol HeadlessSystemTask: AnyObject {
    func complete(success: Bool)
}

private final class ApplicationBackgroundTask: HeadlessSystemTask {
    private let application: UIApplication
    private let lock = NSLock()
    private var identifier: UIBackgroundTaskIdentifier = .invalid

    init(
        updateId: String,
        application: UIApplication = .shared,
        expirationHandler: @escaping () -> Void
    ) {
        self.application = application
        identifier = application.beginBackgroundTask(
            withName: "background-location-\(updateId)",
            expirationHandler: expirationHandler
        )
    }

    func complete(success _: Bool) {
        let taskIdentifier: UIBackgroundTaskIdentifier? = lock.withLock {
            guard identifier != .invalid else { return nil }
            let taskIdentifier = identifier
            identifier = .invalid
            return taskIdentifier
        }
        if let taskIdentifier {
            application.endBackgroundTask(taskIdentifier)
        }
    }
}

private final class ScheduledBackgroundTask: HeadlessSystemTask {
    private let task: BGTask
    private let lock = NSLock()
    private var isCompleted = false

    init(task: BGTask) {
        self.task = task
    }

    func complete(success: Bool) {
        let shouldComplete = lock.withLock {
            guard !isCompleted else { return false }
            isCompleted = true
            return true
        }
        if shouldComplete {
            task.setTaskCompleted(success: success)
        }
    }
}
