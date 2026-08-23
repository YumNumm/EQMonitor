import Testing

struct BackgroundLocationHeadlessTaskStateTests {
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
}
