import Foundation

enum HeadlessTaskLaunchDecision: Equatable {
    case launch
    case coalesced
}

enum HeadlessTaskCompletionResult {
    case success
    case retry
    case terminalFailure
}

struct HeadlessTaskFinishEffect: Equatable {
    let backgroundTaskSucceeded: Bool
    let shouldScheduleRetry: Bool
}

struct HeadlessTaskFinalization: Equatable {
    let nextUpdateId: String?
}

final class HeadlessTaskState {
    private struct ActiveTask {
        let updateId: String
        var queuedUpdateId: String?
        var finishEffect: HeadlessTaskFinishEffect?
    }

    private let lock = NSLock()
    private var activeTask: ActiveTask?

    var activeUpdateId: String? {
        lock.withLock { activeTask?.updateId }
    }

    func begin(updateId: String) -> HeadlessTaskLaunchDecision {
        lock.withLock {
            guard var activeTask else {
                self.activeTask = ActiveTask(
                    updateId: updateId,
                    queuedUpdateId: nil,
                    finishEffect: nil
                )
                return .launch
            }
            if activeTask.updateId != updateId {
                activeTask.queuedUpdateId = updateId
                self.activeTask = activeTask
            }
            return .coalesced
        }
    }

    func complete(
        updateId: String,
        result: HeadlessTaskCompletionResult
    ) -> HeadlessTaskFinishEffect? {
        let effect = switch result {
        case .success, .terminalFailure:
            HeadlessTaskFinishEffect(
                backgroundTaskSucceeded: true,
                shouldScheduleRetry: false
            )
        case .retry:
            HeadlessTaskFinishEffect(
                backgroundTaskSucceeded: false,
                shouldScheduleRetry: true
            )
        }
        return finish(updateId: updateId, effect: effect)
    }

    func expire(updateId: String) -> HeadlessTaskFinishEffect? {
        finish(
            updateId: updateId,
            effect: HeadlessTaskFinishEffect(
                backgroundTaskSucceeded: false,
                shouldScheduleRetry: true
            )
        )
    }

    func finalize(updateId: String) -> HeadlessTaskFinalization? {
        lock.withLock {
            guard let activeTask,
                  activeTask.updateId == updateId,
                  let finishEffect = activeTask.finishEffect
            else {
                return nil
            }
            self.activeTask = nil
            return HeadlessTaskFinalization(
                nextUpdateId: finishEffect.shouldScheduleRetry
                    ? nil
                    : activeTask.queuedUpdateId
            )
        }
    }

    private func finish(
        updateId: String,
        effect: HeadlessTaskFinishEffect
    ) -> HeadlessTaskFinishEffect? {
        lock.withLock {
            guard var activeTask,
                  activeTask.updateId == updateId,
                  activeTask.finishEffect == nil
            else {
                return nil
            }
            activeTask.finishEffect = effect
            self.activeTask = activeTask
            return effect
        }
    }
}
