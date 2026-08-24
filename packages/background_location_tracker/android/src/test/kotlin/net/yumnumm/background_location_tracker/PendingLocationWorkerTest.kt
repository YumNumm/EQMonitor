package net.yumnumm.background_location_tracker

import androidx.work.ListenableWorker
import java.util.concurrent.CountDownLatch
import java.util.concurrent.Executors
import java.util.concurrent.TimeUnit
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.asCoroutineDispatcher
import kotlinx.coroutines.async
import kotlinx.coroutines.cancelAndJoin
import kotlinx.coroutines.runBlocking
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test

class PendingLocationWorkerTest {
    @Test
    fun successAndTerminalFailureBothCompleteWorkSuccessfully() {
        assertTrue(
            HeadlessTaskResult.SUCCESS.toWorkManagerResult() is
                ListenableWorker.Result.Success
        )
        assertTrue(
            HeadlessTaskResult.TERMINAL_FAILURE.toWorkManagerResult() is
                ListenableWorker.Result.Success
        )
        assertTrue(
            HeadlessTaskResult.RETRY.toWorkManagerResult() is
                ListenableWorker.Result.Retry
        )
    }

    @Test
    fun latestPendingUpdateIdIsReadWhenTheWorkerStarts() = runBlocking {
        var executedUpdateId: String? = null
        val delegate = PendingLocationWorkerDelegate(
            peekLatestPending = {
                StoredPendingLocation(
                    updateId = "latest",
                    latitude = 35.0,
                    longitude = 139.0,
                    accuracy = 10.0,
                    timestampMillis = 1_000L
                )
            },
            execute = {
                executedUpdateId = it
                HeadlessTaskResult.SUCCESS
            }
        )

        assertEquals(HeadlessTaskResult.SUCCESS, delegate.execute())
        assertEquals("latest", executedUpdateId)
    }

    @Test
    fun timeoutReturnsRetryAndDestroysTheEngineExactlyOnce() = runBlocking {
        val registry = HeadlessTaskCompletionRegistry()
        val engine = FakeManagedHeadlessEngine()
        val executor = HeadlessWorkerExecutor(
            completionRegistry = registry,
            startEngine = { engine },
            timeoutMillis = 0,
            engineDispatcher = Dispatchers.Unconfined
        )

        assertEquals(HeadlessTaskResult.RETRY, executor.execute(updateId = "timeout"))
        assertEquals(1, engine.destroyCount)
    }

    @Test
    fun dartTerminalCompletionDestroysTheEngineAndReturnsTerminalFailure() = runBlocking {
        val registry = HeadlessTaskCompletionRegistry()
        val engine = FakeManagedHeadlessEngine()
        val executor = HeadlessWorkerExecutor(
            completionRegistry = registry,
            startEngine = { registration ->
                registry.complete(
                    registration = registration,
                    updateId = registration.updateId,
                    result = HeadlessTaskResult.TERMINAL_FAILURE
                )
                engine
            },
            timeoutMillis = 100,
            engineDispatcher = Dispatchers.Unconfined
        )

        assertEquals(
            HeadlessTaskResult.TERMINAL_FAILURE,
            executor.execute(updateId = "terminal")
        )
        assertEquals(1, engine.destroyCount)
    }

    @Test
    fun missingCallbackOrEngineStartupFailureReturnsRetry() = runBlocking {
        val missingCallbackExecutor = HeadlessWorkerExecutor(
            completionRegistry = HeadlessTaskCompletionRegistry(),
            startEngine = { null },
            timeoutMillis = 100,
            engineDispatcher = Dispatchers.Unconfined
        )
        val failedEngineExecutor = HeadlessWorkerExecutor(
            completionRegistry = HeadlessTaskCompletionRegistry(),
            startEngine = { error("engine failed") },
            timeoutMillis = 100,
            engineDispatcher = Dispatchers.Unconfined
        )

        assertEquals(
            HeadlessTaskResult.RETRY,
            missingCallbackExecutor.execute(updateId = "missing-callback")
        )
        assertEquals(
            HeadlessTaskResult.RETRY,
            failedEngineExecutor.execute(updateId = "engine-failure")
        )
    }

    @Test
    fun coroutineCancellationDestroysTheEngineExactlyOnce() = runBlocking {
        val registry = HeadlessTaskCompletionRegistry()
        val engineStarted = CountDownLatch(1)
        val engine = FakeManagedHeadlessEngine()
        val executor = HeadlessWorkerExecutor(
            completionRegistry = registry,
            startEngine = {
                engineStarted.countDown()
                engine
            },
            timeoutMillis = TimeUnit.SECONDS.toMillis(5),
            engineDispatcher = Dispatchers.Unconfined
        )
        val execution = async(Dispatchers.Default) {
            executor.execute(updateId = "stopped")
        }
        assertTrue(engineStarted.await(1, TimeUnit.SECONDS))

        execution.cancelAndJoin()

        assertEquals(1, engine.destroyCount)
    }

    @Test
    fun engineLifecycleRunsOnTheInjectedMainThreadDispatcher() {
        runBlocking {
            val registry = HeadlessTaskCompletionRegistry()
            val engine = FakeManagedHeadlessEngine()
            val engineThread = Executors.newSingleThreadExecutor { runnable ->
                Thread(runnable, "engine-main")
            }
            val engineDispatcher = engineThread.asCoroutineDispatcher()
            var startThreadName: String? = null
            val executor = HeadlessWorkerExecutor(
                completionRegistry = registry,
                startEngine = { registration ->
                    startThreadName = Thread.currentThread().name
                    registry.complete(
                        registration = registration,
                        updateId = registration.updateId,
                        result = HeadlessTaskResult.SUCCESS
                    )
                    engine
                },
                timeoutMillis = 100,
                engineDispatcher = engineDispatcher
            )

            try {
                assertEquals(HeadlessTaskResult.SUCCESS, executor.execute(updateId = "main"))
                assertTrue(startThreadName?.startsWith("engine-main") == true)
                assertTrue(engine.destroyThreadName?.startsWith("engine-main") == true)
            } finally {
                engineDispatcher.close()
                engineThread.shutdownNow()
            }
        }
    }
}

private class FakeManagedHeadlessEngine : ManagedHeadlessEngine {
    override val bindingKey = Any()
    var destroyCount = 0
    var destroyThreadName: String? = null

    override fun registerAndExecute(
        callbackInformation: io.flutter.view.FlutterCallbackInformation,
        appBundlePath: String
    ) = Unit

    override fun destroy() {
        destroyCount += 1
        destroyThreadName = Thread.currentThread().name
    }
}
