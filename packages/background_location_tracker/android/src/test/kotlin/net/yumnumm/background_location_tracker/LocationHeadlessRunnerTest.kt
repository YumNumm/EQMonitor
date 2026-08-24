package net.yumnumm.background_location_tracker

import android.content.Context
import android.content.ContextWrapper
import io.flutter.view.FlutterCallbackInformation
import org.junit.Assert.assertEquals
import org.junit.Assert.assertNull
import org.junit.Assert.assertSame
import org.junit.Assert.assertTrue
import org.junit.Assert.fail
import org.junit.Test

class LocationHeadlessRunnerTest {
    @Test
    fun missingCallbackHandleDoesNotCreateAFlutterEngine() {
        val registry = HeadlessTaskCompletionRegistry()
        val registration = registry.begin(updateId = "missing-handle")
        val runner = LocationHeadlessRunner(
            context = HeadlessRunnerTestContext(),
            completionRegistry = registry,
            callbackHandleReader = { null },
            callbackInformationReader = { error("callback lookup must not run") },
            flutterBundleLoader = { error("Flutter must not initialize") },
            engineFactory = { error("engine must not be created") }
        )

        assertNull(runner.start(registration))
    }

    @Test
    fun coldProcessCreatesAndBindsTheEngineBeforeCallbackLookup() {
        val events = mutableListOf<String>()
        val registry = HeadlessTaskCompletionRegistry()
        val registration = registry.begin(updateId = "cold-process")
        val engine = RunnerFakeManagedHeadlessEngine(events = events)
        var wasBoundDuringLookup = false
        val runner = LocationHeadlessRunner(
            context = HeadlessRunnerTestContext(),
            completionRegistry = registry,
            callbackHandleReader = {
                events += "handle"
                42L
            },
            flutterBundleLoader = {
                events += "loader"
                "app-bundle"
            },
            engineFactory = {
                events += "engine"
                engine
            },
            callbackInformationReader = {
                events += "lookup"
                wasBoundDuringLookup =
                    registry.registrationForEngine(engine.bindingKey) === registration
                testCallbackInformation()
            }
        )

        assertSame(engine, runner.start(registration))
        assertTrue(wasBoundDuringLookup)
        assertEquals(
            listOf("handle", "loader", "engine", "lookup", "register"),
            events
        )
    }

    @Test
    fun missingCallbackInformationDestroysTheCreatedEngineExactlyOnce() {
        val registry = HeadlessTaskCompletionRegistry()
        val registration = registry.begin(updateId = "missing-callback")
        val engine = RunnerFakeManagedHeadlessEngine()
        val runner = LocationHeadlessRunner(
            context = HeadlessRunnerTestContext(),
            completionRegistry = registry,
            callbackHandleReader = { 42L },
            flutterBundleLoader = { "app-bundle" },
            engineFactory = { engine },
            callbackInformationReader = { null }
        )

        assertNull(runner.start(registration))
        assertEquals(1, engine.destroyCount)
        assertNull(registry.registrationForEngine(engine.bindingKey))
    }

    @Test
    fun callbackLookupLinkageErrorDestroysTheCreatedEngineExactlyOnce() {
        val registry = HeadlessTaskCompletionRegistry()
        val registration = registry.begin(updateId = "lookup-linkage-error")
        val engine = RunnerFakeManagedHeadlessEngine()
        val runner = LocationHeadlessRunner(
            context = HeadlessRunnerTestContext(),
            completionRegistry = registry,
            callbackHandleReader = { 42L },
            flutterBundleLoader = { "app-bundle" },
            engineFactory = { engine },
            callbackInformationReader = { throw UnsatisfiedLinkError("cold JNI") }
        )

        try {
            runner.start(registration)
            fail("LinkageError must be propagated to the worker classifier")
        } catch (_: UnsatisfiedLinkError) {
            assertEquals(1, engine.destroyCount)
            assertNull(registry.registrationForEngine(engine.bindingKey))
        }
    }

    @Test
    fun dartStartLinkageErrorDestroysTheCreatedEngineExactlyOnce() {
        val registry = HeadlessTaskCompletionRegistry()
        val registration = registry.begin(updateId = "dart-linkage-error")
        val engine = RunnerFakeManagedHeadlessEngine(
            registerFailure = UnsatisfiedLinkError("Dart JNI")
        )
        val runner = LocationHeadlessRunner(
            context = HeadlessRunnerTestContext(),
            completionRegistry = registry,
            callbackHandleReader = { 42L },
            flutterBundleLoader = { "app-bundle" },
            engineFactory = { engine },
            callbackInformationReader = { testCallbackInformation() }
        )

        try {
            runner.start(registration)
            fail("LinkageError must be propagated to the worker classifier")
        } catch (_: UnsatisfiedLinkError) {
            assertEquals(1, engine.destroyCount)
            assertNull(registry.registrationForEngine(engine.bindingKey))
        }
    }

    @Test
    fun dartStartExceptionDestroysTheCreatedEngineExactlyOnce() {
        val registry = HeadlessTaskCompletionRegistry()
        val registration = registry.begin(updateId = "dart-start-error")
        val engine = RunnerFakeManagedHeadlessEngine(
            registerFailure = IllegalStateException("plugin registration failed")
        )
        val runner = LocationHeadlessRunner(
            context = HeadlessRunnerTestContext(),
            completionRegistry = registry,
            callbackHandleReader = { 42L },
            flutterBundleLoader = { "app-bundle" },
            engineFactory = { engine },
            callbackInformationReader = { testCallbackInformation() }
        )

        try {
            runner.start(registration)
            fail("Engine startup exception must be propagated to the worker classifier")
        } catch (_: IllegalStateException) {
            assertEquals(1, engine.destroyCount)
            assertNull(registry.registrationForEngine(engine.bindingKey))
        }
    }
}

private class HeadlessRunnerTestContext : ContextWrapper(null) {
    override fun getApplicationContext(): Context = this
}

private class RunnerFakeManagedHeadlessEngine(
    private val events: MutableList<String> = mutableListOf(),
    private val registerFailure: Throwable? = null
) : ManagedHeadlessEngine {
    override val bindingKey = Any()
    var destroyCount = 0

    override fun registerAndExecute(
        callbackInformation: FlutterCallbackInformation,
        appBundlePath: String
    ) {
        events += "register"
        registerFailure?.let { throw it }
    }

    override fun destroy() {
        destroyCount += 1
    }
}

private fun testCallbackInformation(): FlutterCallbackInformation {
    val constructor = FlutterCallbackInformation::class.java.getDeclaredConstructor(
        String::class.java,
        String::class.java,
        String::class.java
    )
    constructor.isAccessible = true
    return constructor.newInstance(
        "backgroundLocationCallbackDispatcher",
        "",
        "package:eqmonitor/main.dart"
    )
}
