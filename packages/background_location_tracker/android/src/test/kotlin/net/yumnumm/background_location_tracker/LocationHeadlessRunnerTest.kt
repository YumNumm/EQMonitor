package net.yumnumm.background_location_tracker

import android.content.Context
import android.content.ContextWrapper
import org.junit.Assert.assertNull
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
}

private class HeadlessRunnerTestContext : ContextWrapper(null) {
    override fun getApplicationContext(): Context = this
}
