package net.yumnumm.background_location_tracker

import java.util.IdentityHashMap
import java.util.concurrent.CountDownLatch
import java.util.concurrent.TimeUnit
import java.util.concurrent.atomic.AtomicReference

internal class HeadlessTaskCompletionRegistry {
    internal class Registration internal constructor(
        val updateId: String
    ) {
        internal val completion = AtomicReference<HeadlessTaskResult?>()
        internal val completionLatch = CountDownLatch(1)
    }

    private val lock = Any()
    private var activeRegistration: Registration? = null
    private val engineRegistrations = IdentityHashMap<Any, Registration>()

    fun begin(updateId: String): Registration = synchronized(lock) {
        activeRegistration?.finish(HeadlessTaskResult.RETRY)
        Registration(updateId = updateId).also { activeRegistration = it }
    }

    fun complete(
        registration: Registration,
        updateId: String,
        result: HeadlessTaskResult
    ): Boolean = synchronized(lock) {
        if (activeRegistration !== registration || registration.updateId != updateId) {
            return@synchronized false
        }
        registration.finish(result)
    }

    fun await(
        registration: Registration,
        timeoutMillis: Long
    ): HeadlessTaskResult {
        val completed = registration.completionLatch.await(
            timeoutMillis.coerceAtLeast(0),
            TimeUnit.MILLISECONDS
        )
        if (!completed) {
            complete(
                registration = registration,
                updateId = registration.updateId,
                result = HeadlessTaskResult.RETRY
            )
        }
        return registration.completion.get() ?: HeadlessTaskResult.RETRY
    }

    fun end(registration: Registration) = synchronized(lock) {
        if (activeRegistration === registration) {
            activeRegistration = null
        }
        engineRegistrations.entries.removeAll { it.value === registration }
    }

    fun bindEngine(
        registration: Registration,
        engineKey: Any
    ): Boolean = synchronized(lock) {
        if (activeRegistration !== registration) {
            return@synchronized false
        }
        engineRegistrations[engineKey] = registration
        true
    }

    fun registrationForEngine(engineKey: Any): Registration? = synchronized(lock) {
        engineRegistrations[engineKey]
    }

    fun unbindEngine(
        registration: Registration,
        engineKey: Any
    ) = synchronized(lock) {
        if (engineRegistrations[engineKey] === registration) {
            engineRegistrations.remove(engineKey)
        }
    }

    private fun Registration.finish(result: HeadlessTaskResult): Boolean {
        if (!completion.compareAndSet(null, result)) {
            return false
        }
        completionLatch.countDown()
        return true
    }

    companion object {
        val shared = HeadlessTaskCompletionRegistry()
    }
}
