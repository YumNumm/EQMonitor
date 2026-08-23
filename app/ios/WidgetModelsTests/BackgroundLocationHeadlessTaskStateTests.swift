import Testing
import UIKit

struct BackgroundLocationHeadlessTaskStateTests {
    @Test func backgroundOnlyLaunchConfiguresRegistrantBeforeTaskAndLocationEvents() {
        var steps: [String] = []
        var hasHeadlessRegistrant = false
        var engineLaunchCount = 0

        let bootstrap = BackgroundLocationLaunchBootstrap(
            configurePluginRegistrants: {
                hasHeadlessRegistrant = true
                steps.append("registrant")
            },
            registerRetryTaskHandlers: {
                #expect(hasHeadlessRegistrant)
                steps.append("retry-handlers")
                engineLaunchCount += 1
            },
            restoreLocationMonitoring: {
                #expect(hasHeadlessRegistrant)
                steps.append("location")
                engineLaunchCount += 1
            }
        )

        bootstrap.prepare(isLocationLaunch: true)

        #expect(steps == ["registrant", "retry-handlers", "location"])
        #expect(engineLaunchCount == 2)
    }

    @Test func successfulCompletionRequestsCleanupExactlyOnce() throws {
        let state = HeadlessTaskState()

        #expect(state.begin(updateId: "update-1") == .launch)

        let effect = try #require(
            state.complete(updateId: "update-1", result: .success)
        )
        #expect(effect.backgroundTaskSucceeded)
        #expect(effect.shouldScheduleRetry == false)
        #expect(state.complete(updateId: "update-1", result: .success) == nil)

        let finalization = try #require(state.finalize(updateId: "update-1"))
        #expect(finalization.nextUpdateId == nil)
        #expect(state.finalize(updateId: "update-1") == nil)
    }

    @Test func expirationRequestsRetryAndRejectsLateDartCompletion() throws {
        let state = HeadlessTaskState()
        #expect(state.begin(updateId: "expiring") == .launch)

        let effect = try #require(state.expire(updateId: "expiring"))

        #expect(effect.backgroundTaskSucceeded == false)
        #expect(effect.shouldScheduleRetry)
        #expect(state.complete(updateId: "expiring", result: .success) == nil)
        #expect(state.activeUpdateId == "expiring")
        #expect(state.finalize(updateId: "expiring")?.nextUpdateId == nil)
        #expect(state.activeUpdateId == nil)
    }

    @Test func staleCompletionCannotFinishTheActiveUpdate() {
        let state = HeadlessTaskState()
        #expect(state.begin(updateId: "latest") == .launch)

        #expect(state.complete(updateId: "older", result: .success) == nil)
        #expect(state.activeUpdateId == "latest")
        #expect(state.finalize(updateId: "older") == nil)
    }

    @Test func overlappingLaunchesUseOneEngineAndQueueOnlyTheLatestUpdate() throws {
        let state = HeadlessTaskState()
        var engineLaunchCount = 0

        if state.begin(updateId: "first") == .launch {
            engineLaunchCount += 1
        }
        if state.begin(updateId: "second") == .launch {
            engineLaunchCount += 1
        }
        if state.begin(updateId: "latest") == .launch {
            engineLaunchCount += 1
        }

        #expect(engineLaunchCount == 1)
        _ = try #require(state.complete(updateId: "first", result: .success))
        let finalization = try #require(state.finalize(updateId: "first"))
        #expect(finalization.nextUpdateId == "latest")
    }

    @Test func retrySchedulesDeferredWorkInsteadOfImmediatelyLaunchingQueuedUpdate() throws {
        let state = HeadlessTaskState()
        #expect(state.begin(updateId: "first") == .launch)
        #expect(state.begin(updateId: "latest") == .coalesced)

        let effect = try #require(
            state.complete(updateId: "first", result: .retry)
        )
        let finalization = try #require(state.finalize(updateId: "first"))

        #expect(effect.shouldScheduleRetry)
        #expect(finalization.nextUpdateId == nil)
    }

    @Test func invalidApplicationBackgroundTaskFinalizesRetryWithoutLaunchingEngine() throws {
        let suiteName = "BackgroundLocationHeadlessTaskStateTests.\(UUID().uuidString)"
        let defaults = try #require(UserDefaults(suiteName: suiteName))
        defer { defaults.removePersistentDomain(forName: suiteName) }
        let pendingStore = PendingLocationStore(
            storage: HeadlessFakePendingLocationRecordStorage(),
            legacyUserDefaults: defaults,
            updateIdProvider: { "no-background-time" }
        )
        _ = try #require(pendingStore.save(
            latitude: 35,
            longitude: 139,
            accuracy: 10,
            timestampMillis: 1_700_000_000_000
        ))
        let application = FakeBackgroundTaskApplication(nextIdentifier: .invalid)
        let submitter = FakeRetryRequestSubmitter()
        let scheduler = makeRetryScheduler(submitter: submitter)
        let state = HeadlessTaskState()
        let coordinator = HeadlessApplicationExecutionCoordinator(
            state: state,
            taskStarter: ApplicationBackgroundTaskStarter(application: application),
            retryScheduler: scheduler
        )
        var engineLaunchCount = 0

        let preparation = coordinator.prepare(
            updateId: "no-background-time",
            expirationHandler: {}
        )
        if case .launch = preparation {
            engineLaunchCount += 1
        }
        guard case let .retryFinalized(retryResult) = preparation else {
            Issue.record("invalid background task must finalize as retry")
            return
        }

        #expect(engineLaunchCount == 0)
        #expect(retryResult.hasScheduledRequest)
        #expect(state.activeUpdateId == nil)
        #expect(state.finalize(updateId: "no-background-time") == nil)
        #expect(
            pendingStore.peek(consumer: .deviceLocation)?.updateId
                == "no-background-time"
        )
        #expect(application.beginCount == 1)
        #expect(application.endedIdentifiers.isEmpty)
        #expect(submitter.attempts == [
            .init(kind: .appRefresh, identifier: "refresh-id"),
            .init(kind: .processing, identifier: "processing-id"),
        ])
    }

    @Test func retrySchedulingContinuesWhenOneRequestFails() {
        let submitter = FakeRetryRequestSubmitter(
            errors: [.appRefresh: NSError(domain: "test", code: 7)]
        )
        var diagnostics: [HeadlessRetrySubmissionFailure] = []
        let scheduler = makeRetryScheduler(
            submitter: submitter,
            diagnose: { diagnostics.append($0) }
        )

        let result = scheduler.scheduleRetry()

        #expect(result.hasScheduledRequest)
        #expect(result.successfulIdentifiers == ["processing-id"])
        #expect(result.failures == [
            HeadlessRetrySubmissionFailure(identifier: "refresh-id", errorCode: 7),
        ])
        #expect(diagnostics == result.failures)
        #expect(submitter.attempts == [
            .init(kind: .appRefresh, identifier: "refresh-id"),
            .init(kind: .processing, identifier: "processing-id"),
        ])
    }

    @Test func retrySchedulingReportsBothFailuresAndCanBeResubmitted() {
        let submitter = FakeRetryRequestSubmitter(
            errors: [
                .appRefresh: NSError(domain: "test", code: 1),
                .processing: NSError(domain: "test", code: 2),
            ]
        )
        var diagnostics: [HeadlessRetrySubmissionFailure] = []
        let scheduler = makeRetryScheduler(
            submitter: submitter,
            diagnose: { diagnostics.append($0) }
        )

        let failedResult = scheduler.scheduleRetry()
        submitter.errors = [:]
        let resubmittedResult = scheduler.scheduleRetry()

        #expect(failedResult.hasScheduledRequest == false)
        #expect(failedResult.failures == [
            HeadlessRetrySubmissionFailure(identifier: "refresh-id", errorCode: 1),
            HeadlessRetrySubmissionFailure(identifier: "processing-id", errorCode: 2),
        ])
        #expect(diagnostics == failedResult.failures)
        #expect(resubmittedResult.hasScheduledRequest)
        #expect(resubmittedResult.successfulIdentifiers == ["refresh-id", "processing-id"])
        #expect(submitter.attempts.count == 4)
    }
}

private func makeRetryScheduler(
    submitter: FakeRetryRequestSubmitter,
    diagnose: @escaping (HeadlessRetrySubmissionFailure) -> Void = { _ in }
) -> HeadlessRetryScheduler {
    HeadlessRetryScheduler(
        appRefreshIdentifier: "refresh-id",
        processingIdentifier: "processing-id",
        submitter: submitter,
        diagnose: diagnose
    )
}

private final class FakeBackgroundTaskApplication: HeadlessBackgroundTaskApplication {
    let nextIdentifier: UIBackgroundTaskIdentifier
    private(set) var beginCount = 0
    private(set) var endedIdentifiers: [UIBackgroundTaskIdentifier] = []

    init(nextIdentifier: UIBackgroundTaskIdentifier) {
        self.nextIdentifier = nextIdentifier
    }

    func beginTask(
        name _: String,
        expirationHandler _: @escaping () -> Void
    ) -> UIBackgroundTaskIdentifier {
        beginCount += 1
        return nextIdentifier
    }

    func endTask(identifier: UIBackgroundTaskIdentifier) {
        endedIdentifiers.append(identifier)
    }
}

private final class FakeRetryRequestSubmitter: HeadlessRetryRequestSubmitting {
    var errors: [HeadlessRetryRequestKind: NSError]
    private(set) var attempts: [HeadlessRetryRequest] = []

    init(errors: [HeadlessRetryRequestKind: NSError] = [:]) {
        self.errors = errors
    }

    func submit(_ request: HeadlessRetryRequest) throws {
        attempts.append(request)
        if let error = errors[request.kind] {
            throw error
        }
    }
}

private final class HeadlessFakePendingLocationRecordStorage: PendingLocationRecordStorage {
    private var data: Data?

    func read() -> PendingLocationRecordStorageReadResult {
        if let data {
            return .data(data)
        }
        return .missing
    }

    func write(_ data: Data) -> Bool {
        self.data = data
        return true
    }

    func remove() -> Bool {
        data = nil
        return true
    }
}
