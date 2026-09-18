package net.yumnumm.background_location_tracker

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertTrue
import org.junit.Test

class HeadlessTaskCompletionRegistryTest {
    @Test
    fun onlyTheMatchingUpdateCompletesTheWaitingTask() {
        val registry = HeadlessTaskCompletionRegistry()
        val registration = registry.begin(updateId = "current")

        assertFalse(
            registry.complete(
                registration = registration,
                updateId = "stale",
                result = HeadlessTaskResult.SUCCESS
            )
        )
        assertTrue(
            registry.complete(
                registration = registration,
                updateId = "current",
                result = HeadlessTaskResult.SUCCESS
            )
        )
        assertEquals(
            HeadlessTaskResult.SUCCESS,
            registry.await(registration = registration, timeoutMillis = 100)
        )
    }

    @Test
    fun aNewRegistrationMakesThePreviousCompletionStale() {
        val registry = HeadlessTaskCompletionRegistry()
        val previous = registry.begin(updateId = "previous")
        val latest = registry.begin(updateId = "latest")

        assertFalse(
            registry.complete(
                registration = previous,
                updateId = "previous",
                result = HeadlessTaskResult.SUCCESS
            )
        )
        assertEquals(
            HeadlessTaskResult.RETRY,
            registry.await(registration = previous, timeoutMillis = 100)
        )
        assertTrue(
            registry.complete(
                registration = latest,
                updateId = "latest",
                result = HeadlessTaskResult.TERMINAL_FAILURE
            )
        )
    }

    @Test
    fun timeoutReturnsRetryAndRejectsLateCompletion() {
        val registry = HeadlessTaskCompletionRegistry()
        val registration = registry.begin(updateId = "timeout")

        assertEquals(
            HeadlessTaskResult.RETRY,
            registry.await(registration = registration, timeoutMillis = 0)
        )
        assertFalse(
            registry.complete(
                registration = registration,
                updateId = "timeout",
                result = HeadlessTaskResult.SUCCESS
            )
        )
    }

    @Test
    fun duplicateCompletionIsIgnored() {
        val registry = HeadlessTaskCompletionRegistry()
        val registration = registry.begin(updateId = "duplicate")

        assertTrue(
            registry.complete(
                registration = registration,
                updateId = "duplicate",
                result = HeadlessTaskResult.RETRY
            )
        )
        assertFalse(
            registry.complete(
                registration = registration,
                updateId = "duplicate",
                result = HeadlessTaskResult.SUCCESS
            )
        )
        assertEquals(
            HeadlessTaskResult.RETRY,
            registry.await(registration = registration, timeoutMillis = 100)
        )
    }

    @Test
    fun engineBindingKeepsTheRegistrationScopedToItsFlutterEngine() {
        val registry = HeadlessTaskCompletionRegistry()
        val registration = registry.begin(updateId = "engine-task")
        val engineKey = Any()

        assertTrue(
            registry.bindEngine(
                registration = registration,
                engineKey = engineKey
            )
        )
        assertEquals(registration, registry.registrationForEngine(engineKey))

        registry.end(registration)

        assertEquals(null, registry.registrationForEngine(engineKey))
    }

    @Test
    fun supersedingARegistrationInvalidatesItsEngineBinding() {
        val registry = HeadlessTaskCompletionRegistry()
        val oldRegistration = registry.begin(updateId = "old")
        val oldEngineKey = Any()
        assertTrue(
            registry.bindEngine(
                registration = oldRegistration,
                engineKey = oldEngineKey
            )
        )

        val newRegistration = registry.begin(updateId = "new")

        assertEquals(null, registry.registrationForEngine(oldEngineKey))
        assertFalse(
            registry.complete(
                registration = oldRegistration,
                updateId = "old",
                result = HeadlessTaskResult.SUCCESS
            )
        )
        assertEquals(
            HeadlessTaskResult.RETRY,
            registry.await(registration = oldRegistration, timeoutMillis = 100)
        )

        val newEngineKey = Any()
        assertTrue(
            registry.bindEngine(
                registration = newRegistration,
                engineKey = newEngineKey
            )
        )
        registry.end(oldRegistration)

        assertEquals(newRegistration, registry.registrationForEngine(newEngineKey))
        assertTrue(
            registry.complete(
                registration = newRegistration,
                updateId = "new",
                result = HeadlessTaskResult.SUCCESS
            )
        )
    }

    @Test
    fun engineBridgeRechecksActiveRegistrationBeforeExposingTheTaskId() {
        val registry = HeadlessTaskCompletionRegistry()
        val oldRegistration = registry.begin(updateId = "old")
        val oldEngineKey = Any()
        assertTrue(
            registry.bindEngine(
                registration = oldRegistration,
                engineKey = oldEngineKey
            )
        )
        val bridge = HeadlessEngineCompletionBridge(
            completionRegistry = registry,
            engineKey = oldEngineKey
        )
        assertEquals("old", bridge.activeUpdateId())

        val newRegistration = registry.begin(updateId = "new")
        val newEngineKey = Any()
        assertTrue(
            registry.bindEngine(
                registration = newRegistration,
                engineKey = newEngineKey
            )
        )

        assertEquals(null, bridge.activeUpdateId())
        assertFalse(
            bridge.complete(
                updateId = "old",
                result = HeadlessTaskResult.SUCCESS
            )
        )
        assertEquals(newRegistration, registry.registrationForEngine(newEngineKey))
    }
}
