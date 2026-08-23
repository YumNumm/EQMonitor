package net.yumnumm.background_location_tracker

import android.content.Context
import android.content.ContextWrapper
import android.content.SharedPreferences
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Test

class PendingLocationStoreTest {
    @Test
    fun staleAcknowledgeKeepsTheLatestLocation() {
        val store = PendingLocationStore(TestContext()) { "new-id" }
        val stored = requireNotNull(
            store.save(
                latitude = 35.0,
                longitude = 139.0,
                accuracy = 10.0,
                timestampMillis = 1_000L
            )
        )

        assertEquals("new-id", stored.updateId)
        assertFalse(
            store.acknowledge(
                updateId = "older-id",
                consumer = PendingLocationStore.Consumer.DEVICE_LOCATION
            )
        )
        assertEquals(
            "new-id",
            store.peek(PendingLocationStore.Consumer.DEVICE_LOCATION)?.updateId
        )
    }

    @Test
    fun locationRemainsUntilBothConsumersAcknowledge() {
        val store = PendingLocationStore(TestContext()) { "new-id" }
        val stored = requireNotNull(
            store.save(
                latitude = 36.0,
                longitude = 140.0,
                accuracy = 20.0,
                timestampMillis = 2_000L
            )
        )

        assertTrue(
            store.acknowledge(
                updateId = stored.updateId,
                consumer = PendingLocationStore.Consumer.DEVICE_LOCATION
            )
        )
        assertNull(store.peek(PendingLocationStore.Consumer.DEVICE_LOCATION))
        assertEquals(
            stored.updateId,
            store.peek(PendingLocationStore.Consumer.APP_EFFECTS)?.updateId
        )

        assertTrue(
            store.acknowledge(
                updateId = stored.updateId,
                consumer = PendingLocationStore.Consumer.APP_EFFECTS
            )
        )
        assertNull(store.peek(PendingLocationStore.Consumer.APP_EFFECTS))
    }

    @Test
    fun failedSaveIsNotExposedAsPending() {
        val store = PendingLocationStore(
            TestContext(InMemorySharedPreferences(commitSucceeds = false))
        ) { "new-id" }

        assertNull(
            store.save(
                latitude = 36.0,
                longitude = 140.0,
                accuracy = 20.0,
                timestampMillis = 2_000L
            )
        )
        assertNull(store.peek(PendingLocationStore.Consumer.DEVICE_LOCATION))
        assertNull(store.peek(PendingLocationStore.Consumer.APP_EFFECTS))
    }
}

private class TestContext(
    private val preferences: SharedPreferences = InMemorySharedPreferences()
) : ContextWrapper(null) {

    override fun getApplicationContext(): Context = this

    override fun getSharedPreferences(name: String?, mode: Int): SharedPreferences = preferences
}

private class InMemorySharedPreferences(
    private val commitSucceeds: Boolean = true
) : SharedPreferences {
    private val values = mutableMapOf<String, Any?>()

    override fun getAll(): Map<String, *> = values.toMap()
    override fun getString(key: String?, default: String?): String? =
        values[key] as? String ?: default

    override fun getStringSet(key: String?, default: Set<String>?): Set<String>? =
        @Suppress("UNCHECKED_CAST")
        ((values[key] as? Set<String>) ?: default)

    override fun getInt(key: String?, default: Int): Int = values[key] as? Int ?: default
    override fun getLong(key: String?, default: Long): Long = values[key] as? Long ?: default
    override fun getFloat(key: String?, default: Float): Float = values[key] as? Float ?: default
    override fun getBoolean(key: String?, default: Boolean): Boolean =
        values[key] as? Boolean ?: default

    override fun contains(key: String?): Boolean = values.containsKey(key)
    override fun edit(): SharedPreferences.Editor = Editor(values, commitSucceeds)
    override fun registerOnSharedPreferenceChangeListener(
        listener: SharedPreferences.OnSharedPreferenceChangeListener?
    ) = Unit

    override fun unregisterOnSharedPreferenceChangeListener(
        listener: SharedPreferences.OnSharedPreferenceChangeListener?
    ) = Unit

    private class Editor(
        private val values: MutableMap<String, Any?>,
        private val commitSucceeds: Boolean
    ) : SharedPreferences.Editor {
        private val updates = mutableMapOf<String, Any?>()
        private val removals = mutableSetOf<String>()
        private var clear = false

        override fun putString(key: String?, value: String?) = put(key, value)
        override fun putStringSet(key: String?, value: Set<String>?) = put(key, value)
        override fun putInt(key: String?, value: Int) = put(key, value)
        override fun putLong(key: String?, value: Long) = put(key, value)
        override fun putFloat(key: String?, value: Float) = put(key, value)
        override fun putBoolean(key: String?, value: Boolean) = put(key, value)

        override fun remove(key: String?): SharedPreferences.Editor = apply {
            if (key != null) removals += key
        }

        override fun clear(): SharedPreferences.Editor = apply { clear = true }
        override fun commit(): Boolean {
            applyChanges()
            return commitSucceeds
        }

        override fun apply() = applyChanges()

        private fun put(key: String?, value: Any?): SharedPreferences.Editor = apply {
            if (key != null) updates[key] = value
        }

        private fun applyChanges() {
            if (clear) values.clear()
            removals.forEach(values::remove)
            updates.forEach { (key, value) ->
                if (value == null) values.remove(key) else values[key] = value
            }
        }
    }
}
