import Foundation
import UIKit

public struct BackgroundLocationLaunchBootstrap {
    private let configurePluginRegistrants: () -> Void
    private let registerRetryTaskHandlers: () -> Void
    private let restoreLocationMonitoring: () -> Void

    public init(
        configurePluginRegistrants: @escaping () -> Void,
        registerRetryTaskHandlers: @escaping () -> Void,
        restoreLocationMonitoring: @escaping () -> Void
    ) {
        self.configurePluginRegistrants = configurePluginRegistrants
        self.registerRetryTaskHandlers = registerRetryTaskHandlers
        self.restoreLocationMonitoring = restoreLocationMonitoring
    }

    public func prepare(isLocationLaunch: Bool) {
        configurePluginRegistrants()
        registerRetryTaskHandlers()
        if isLocationLaunch {
            restoreLocationMonitoring()
        }
    }
}

final class HeadlessApplicationActiveRetryObserver {
    private let notificationCenter: NotificationCenter
    private let hasPendingLocation: () -> Bool
    private let resubmitRetry: () -> Void
    private let lock = NSLock()
    private var observerToken: NSObjectProtocol?

    init(
        notificationCenter: NotificationCenter,
        hasPendingLocation: @escaping () -> Bool,
        resubmitRetry: @escaping () -> Void
    ) {
        self.notificationCenter = notificationCenter
        self.hasPendingLocation = hasPendingLocation
        self.resubmitRetry = resubmitRetry
    }

    func start() {
        lock.withLock {
            guard observerToken == nil else { return }
            let hasPendingLocation = self.hasPendingLocation
            let resubmitRetry = self.resubmitRetry
            observerToken = notificationCenter.addObserver(
                forName: UIApplication.didBecomeActiveNotification,
                object: nil,
                queue: nil
            ) { _ in
                guard hasPendingLocation() else { return }
                resubmitRetry()
            }
        }
    }

    deinit {
        let token = lock.withLock {
            let token = observerToken
            observerToken = nil
            return token
        }
        if let token {
            notificationCenter.removeObserver(token)
        }
    }
}

protocol HeadlessSystemTask: AnyObject {
    func complete(success: Bool)
}

protocol HeadlessBackgroundTaskApplication: AnyObject {
    func beginTask(
        name: String,
        expirationHandler: @escaping () -> Void
    ) -> UIBackgroundTaskIdentifier

    func endTask(identifier: UIBackgroundTaskIdentifier)
}

final class UIKitBackgroundTaskApplication: HeadlessBackgroundTaskApplication {
    private let application: UIApplication

    init(application: UIApplication = .shared) {
        self.application = application
    }

    func beginTask(
        name: String,
        expirationHandler: @escaping () -> Void
    ) -> UIBackgroundTaskIdentifier {
        application.beginBackgroundTask(
            withName: name,
            expirationHandler: expirationHandler
        )
    }

    func endTask(identifier: UIBackgroundTaskIdentifier) {
        application.endBackgroundTask(identifier)
    }
}

final class ApplicationBackgroundTaskStarter {
    private let application: HeadlessBackgroundTaskApplication

    init(application: HeadlessBackgroundTaskApplication) {
        self.application = application
    }

    func start(
        updateId: String,
        expirationHandler: @escaping () -> Void
    ) -> HeadlessSystemTask? {
        ApplicationBackgroundTask(
            updateId: updateId,
            application: application,
            expirationHandler: expirationHandler
        )
    }
}

private final class ApplicationBackgroundTask: HeadlessSystemTask {
    private let application: HeadlessBackgroundTaskApplication
    private let lock = NSLock()
    private var identifier: UIBackgroundTaskIdentifier

    init?(
        updateId: String,
        application: HeadlessBackgroundTaskApplication,
        expirationHandler: @escaping () -> Void
    ) {
        self.application = application
        identifier = application.beginTask(
            name: "background-location-\(updateId)",
            expirationHandler: expirationHandler
        )
        guard identifier != .invalid else {
            return nil
        }
    }

    func complete(success _: Bool) {
        let taskIdentifier: UIBackgroundTaskIdentifier? = lock.withLock {
            guard identifier != .invalid else { return nil }
            let taskIdentifier = identifier
            identifier = .invalid
            return taskIdentifier
        }
        if let taskIdentifier {
            application.endTask(identifier: taskIdentifier)
        }
    }
}

enum HeadlessRetryRequestKind: Hashable {
    case appRefresh
    case processing
}

struct HeadlessRetryRequest: Equatable {
    let kind: HeadlessRetryRequestKind
    let identifier: String
}

protocol HeadlessRetryRequestSubmitting {
    func submit(_ request: HeadlessRetryRequest) throws
}

struct HeadlessRetrySubmissionFailure: Equatable {
    let identifier: String
    let errorCode: Int
}

struct HeadlessRetryScheduleResult: Equatable {
    let successfulIdentifiers: [String]
    let failures: [HeadlessRetrySubmissionFailure]

    var hasScheduledRequest: Bool {
        !successfulIdentifiers.isEmpty
    }
}

protocol HeadlessRetryScheduling {
    @discardableResult
    func scheduleRetry() -> HeadlessRetryScheduleResult
}

final class HeadlessRetryScheduler: HeadlessRetryScheduling {
    private let requests: [HeadlessRetryRequest]
    private let submitter: HeadlessRetryRequestSubmitting
    private let diagnose: (HeadlessRetrySubmissionFailure) -> Void

    init(
        appRefreshIdentifier: String,
        processingIdentifier: String,
        submitter: HeadlessRetryRequestSubmitting,
        diagnose: @escaping (HeadlessRetrySubmissionFailure) -> Void
    ) {
        requests = [
            HeadlessRetryRequest(
                kind: .appRefresh,
                identifier: appRefreshIdentifier
            ),
            HeadlessRetryRequest(
                kind: .processing,
                identifier: processingIdentifier
            ),
        ]
        self.submitter = submitter
        self.diagnose = diagnose
    }

    func scheduleRetry() -> HeadlessRetryScheduleResult {
        var successfulIdentifiers: [String] = []
        var failures: [HeadlessRetrySubmissionFailure] = []

        for request in requests {
            do {
                try submitter.submit(request)
                successfulIdentifiers.append(request.identifier)
            } catch {
                let failure = HeadlessRetrySubmissionFailure(
                    identifier: request.identifier,
                    errorCode: (error as NSError).code
                )
                failures.append(failure)
                diagnose(failure)
            }
        }

        return HeadlessRetryScheduleResult(
            successfulIdentifiers: successfulIdentifiers,
            failures: failures
        )
    }
}

enum HeadlessApplicationExecutionPreparation {
    case launch(HeadlessSystemTask)
    case coalesced(HeadlessRetryScheduleResult)
    case retryFinalized(HeadlessRetryScheduleResult)
}

final class HeadlessApplicationExecutionCoordinator {
    private let state: HeadlessTaskState
    private let taskStarter: ApplicationBackgroundTaskStarter
    private let retryScheduler: HeadlessRetryScheduling

    init(
        state: HeadlessTaskState,
        taskStarter: ApplicationBackgroundTaskStarter,
        retryScheduler: HeadlessRetryScheduling
    ) {
        self.state = state
        self.taskStarter = taskStarter
        self.retryScheduler = retryScheduler
    }

    func prepare(
        updateId: String,
        expirationHandler: @escaping () -> Void
    ) -> HeadlessApplicationExecutionPreparation {
        guard state.begin(updateId: updateId) == .launch else {
            return .coalesced(retryScheduler.scheduleRetry())
        }
        guard let task = taskStarter.start(
            updateId: updateId,
            expirationHandler: expirationHandler
        ) else {
            _ = state.complete(updateId: updateId, result: .retry)
            _ = state.finalize(updateId: updateId)
            return .retryFinalized(retryScheduler.scheduleRetry())
        }
        return .launch(task)
    }
}
