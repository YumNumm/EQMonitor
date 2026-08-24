package net.yumnumm.background_location_tracker

import android.content.Context
import androidx.work.CoroutineWorker
import androidx.work.ListenableWorker
import androidx.work.WorkerParameters
import java.util.concurrent.CancellationException
import java.util.concurrent.TimeUnit
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.NonCancellable
import kotlinx.coroutines.runInterruptible
import kotlinx.coroutines.withContext

internal enum class ForegroundServiceRequirement {
    NONE,
    BASE_PERMISSION,
    DATA_SYNC_TYPE
}

internal object PendingLocationWorkerPolicy {
    const val WORKER_TIMEOUT_MILLIS = 60_000L
    private val workManagerExecutionLimitMillis = TimeUnit.MINUTES.toMillis(10)

    fun foregroundServiceRequirement(
        sdkInt: Int,
        timeoutMillis: Long
    ): ForegroundServiceRequirement {
        if (timeoutMillis < workManagerExecutionLimitMillis) {
            return ForegroundServiceRequirement.NONE
        }
        return if (sdkInt >= 34) {
            ForegroundServiceRequirement.DATA_SYNC_TYPE
        } else {
            ForegroundServiceRequirement.BASE_PERMISSION
        }
    }
}

internal fun HeadlessTaskResult.toWorkManagerResult(): ListenableWorker.Result = when (this) {
    HeadlessTaskResult.SUCCESS,
    HeadlessTaskResult.TERMINAL_FAILURE -> ListenableWorker.Result.success()
    HeadlessTaskResult.RETRY -> ListenableWorker.Result.retry()
}

internal class PendingLocationWorkerDelegate(
    private val peekLatestPending: () -> StoredPendingLocation?,
    private val execute: suspend (String) -> HeadlessTaskResult
) {
    suspend fun execute(): HeadlessTaskResult {
        val pending = peekLatestPending() ?: return HeadlessTaskResult.SUCCESS
        return execute(pending.updateId)
    }
}

internal class HeadlessWorkerExecutor(
    private val completionRegistry: HeadlessTaskCompletionRegistry,
    private val startEngine: (
        HeadlessTaskCompletionRegistry.Registration
    ) -> ManagedHeadlessEngine?,
    private val timeoutMillis: Long,
    private val engineDispatcher: CoroutineDispatcher = Dispatchers.Main.immediate
) {
    private val lifecycleLock = Any()
    private var activeRegistration: HeadlessTaskCompletionRegistry.Registration? = null
    private var activeEngine: ManagedHeadlessEngine? = null

    suspend fun execute(updateId: String): HeadlessTaskResult {
        val registration = completionRegistry.begin(updateId = updateId)
        synchronized(lifecycleLock) {
            activeRegistration = registration
        }
        var result = HeadlessTaskResult.RETRY
        var cleanupSucceeded = true
        try {
            val engine = withContext(engineDispatcher + NonCancellable) {
                startEngine(registration)?.also { startedEngine ->
                    synchronized(lifecycleLock) {
                        activeEngine = startedEngine
                    }
                }
            }
            if (engine != null) {
                result = runInterruptible(Dispatchers.IO) {
                    completionRegistry.await(
                        registration = registration,
                        timeoutMillis = timeoutMillis
                    )
                }
            }
        } catch (error: CancellationException) {
            throw error
        } catch (_: InterruptedException) {
            Thread.currentThread().interrupt()
        } catch (_: Exception) {
            result = HeadlessTaskResult.RETRY
        } finally {
            cleanupSucceeded = withContext(engineDispatcher + NonCancellable) {
                releaseEngine(registration)
            }
            completionRegistry.end(registration)
            synchronized(lifecycleLock) {
                if (activeRegistration === registration) {
                    activeRegistration = null
                }
            }
        }
        return if (cleanupSucceeded) result else HeadlessTaskResult.RETRY
    }

    private fun releaseEngine(
        registration: HeadlessTaskCompletionRegistry.Registration
    ): Boolean {
        val engine = synchronized(lifecycleLock) {
            if (activeRegistration !== registration) {
                return@synchronized null
            }
            activeEngine.also { activeEngine = null }
        } ?: return true
        completionRegistry.unbindEngine(registration, engine.bindingKey)
        return try {
            engine.destroy()
            true
        } catch (_: Exception) {
            false
        }
    }
}

class PendingLocationWorker(
    appContext: Context,
    workerParameters: WorkerParameters
) : CoroutineWorker(appContext, workerParameters) {
    private val pendingStore = PendingLocationStore(applicationContext)
    private val executor = HeadlessWorkerExecutor(
        completionRegistry = HeadlessTaskCompletionRegistry.shared,
        startEngine = LocationHeadlessRunner(
            context = applicationContext,
            completionRegistry = HeadlessTaskCompletionRegistry.shared
        )::start,
        timeoutMillis = PendingLocationWorkerPolicy.WORKER_TIMEOUT_MILLIS
    )

    override suspend fun doWork(): ListenableWorker.Result =
        PendingLocationWorkerDelegate(
            peekLatestPending = {
                pendingStore.peek(PendingLocationStore.Consumer.DEVICE_LOCATION)
            },
            execute = executor::execute
        ).execute().toWorkManagerResult()
}
