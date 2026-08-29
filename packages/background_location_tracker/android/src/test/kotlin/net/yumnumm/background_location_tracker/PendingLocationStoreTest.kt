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
    fun legacyLocationMigratesToThePendingRecord() {
        val preferences = InMemorySharedPreferences()
        preferences.edit()
            .putLong("pending_lat_bits", java.lang.Double.doubleToRawLongBits(35.0))
            .putLong("pending_lon_bits", java.lang.Double.doubleToRawLongBits(139.0))
            .putLong("pending_ts", 1_234_567L)
            .commit()
        val store = PendingLocationStore(TestContext(preferences)) { "migrated-id" }

        val migrated = requireNotNull(
            store.peek(PendingLocationStore.Consumer.DEVICE_LOCATION)
        )

        assertEquals("migrated-id", migrated.updateId)
        assertEquals(35.0, migrated.latitude, 0.0)
        assertEquals(139.0, migrated.longitude, 0.0)
        assertEquals(0.0, migrated.accuracy, 0.0)
        assertEquals(1_234_567L, migrated.timestampMillis)
        assertEquals(
            "migrated-id",
            store.peek(PendingLocationStore.Consumer.APP_EFFECTS)?.updateId
        )
        assertFalse(preferences.contains("pending_lat_bits"))
        assertFalse(preferences.contains("pending_lon_bits"))
        assertFalse(preferences.contains("pending_ts"))
    }

    @Test
    fun failedLegacyMigrationKeepsTheLegacyLocationForRetry() {
        val preferences = InMemorySharedPreferences()
        preferences.edit()
            .putLong("pending_lat_bits", java.lang.Double.doubleToRawLongBits(36.0))
            .putLong("pending_lon_bits", java.lang.Double.doubleToRawLongBits(140.0))
            .putLong("pending_ts", 2_345_678L)
            .commit()
        val store = PendingLocationStore(TestContext(preferences)) { "migrated-id" }
        preferences.failNextCommit()

        assertNull(store.peek(PendingLocationStore.Consumer.DEVICE_LOCATION))
        assertTrue(preferences.contains("pending_lat_bits"))
        assertTrue(preferences.contains("pending_lon_bits"))
        assertTrue(preferences.contains("pending_ts"))

        assertEquals(
            "migrated-id",
            store.peek(PendingLocationStore.Consumer.DEVICE_LOCATION)?.updateId
        )
    }

    @Test
    fun incompleteLegacyLocationRemovesRawCoordinateKeys() {
        val preferences = InMemorySharedPreferences()
        preferences.edit()
            .putLong("pending_lat_bits", java.lang.Double.doubleToRawLongBits(35.0))
            .putLong("pending_ts", 1_234_567L)
            .commit()
        val store = PendingLocationStore(TestContext(preferences))

        assertNull(store.peek(PendingLocationStore.Consumer.DEVICE_LOCATION))
        assertFalse(preferences.contains("pending_lat_bits"))
        assertFalse(preferences.contains("pending_lon_bits"))
        assertFalse(preferences.contains("pending_ts"))
    }

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
        val preferences = InMemorySharedPreferences()
        val store = PendingLocationStore(TestContext(preferences)) { "new-id" }
        preferences.failNextCommit()

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

    @Test
    fun failedSaveRestoresThePreviousCompleteLocation() {
        val preferences = InMemorySharedPreferences()
        val updateIds = ArrayDeque(listOf("previous-id", "new-id"))
        val store = PendingLocationStore(TestContext(preferences)) {
            updateIds.removeFirst()
        }
        requireNotNull(
            store.save(
                latitude = 35.0,
                longitude = 139.0,
                accuracy = 10.0,
                timestampMillis = 1_000L
            )
        )
        preferences.failNextCommit()

        assertNull(
            store.save(
                latitude = 36.0,
                longitude = 140.0,
                accuracy = 20.0,
                timestampMillis = 2_000L
            )
        )

        assertEquals(
            "previous-id",
            store.peek(PendingLocationStore.Consumer.DEVICE_LOCATION)?.updateId
        )
        assertEquals(
            "previous-id",
            store.peek(PendingLocationStore.Consumer.APP_EFFECTS)?.updateId
        )
    }

    @Test
    fun failedDeviceLocationAcknowledgeKeepsBothConsumersPending() {
        val preferences = InMemorySharedPreferences()
        val store = PendingLocationStore(TestContext(preferences)) { "pending-id" }
        requireNotNull(
            store.save(
                latitude = 35.0,
                longitude = 139.0,
                accuracy = 10.0,
                timestampMillis = 1_000L
            )
        )
        preferences.failNextCommit()

        assertFalse(
            store.acknowledge(
                updateId = "pending-id",
                consumer = PendingLocationStore.Consumer.DEVICE_LOCATION
            )
        )
        assertEquals(
            "pending-id",
            store.peek(PendingLocationStore.Consumer.DEVICE_LOCATION)?.updateId
        )
        assertEquals(
            "pending-id",
            store.peek(PendingLocationStore.Consumer.APP_EFFECTS)?.updateId
        )
    }

    @Test
    fun failedFinalAppEffectsAcknowledgeRestoresThePendingLocation() {
        val preferences = InMemorySharedPreferences()
        val store = PendingLocationStore(TestContext(preferences)) { "pending-id" }
        requireNotNull(
            store.save(
                latitude = 35.0,
                longitude = 139.0,
                accuracy = 10.0,
                timestampMillis = 1_000L
            )
        )
        assertTrue(
            store.acknowledge(
                updateId = "pending-id",
                consumer = PendingLocationStore.Consumer.DEVICE_LOCATION
            )
        )
        preferences.failNextCommit()

        assertFalse(
            store.acknowledge(
                updateId = "pending-id",
                consumer = PendingLocationStore.Consumer.APP_EFFECTS
            )
        )
        assertNull(store.peek(PendingLocationStore.Consumer.DEVICE_LOCATION))
        assertEquals(
            "pending-id",
            store.peek(PendingLocationStore.Consumer.APP_EFFECTS)?.updateId
        )
    }
}

internal class TestContext(
    private val preferences: SharedPreferences = InMemorySharedPreferences()
) : ContextWrapper(null) {

    override fun getApplicationContext(): Context = this

    override fun getSharedPreferences(name: String?, mode: Int): SharedPreferences = preferences
}

internal class InMemorySharedPreferences : SharedPreferences {
    private val values = mutableMapOf<String, Any?>()
    private val commitResults = ArrayDeque<Boolean>()

    fun failNextCommit() {
        commitResults.addLast(false)
    }

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
    override fun edit(): SharedPreferences.Editor = Editor(values, commitResults)
    override fun registerOnSharedPreferenceChangeListener(
        listener: SharedPreferences.OnSharedPreferenceChangeListener?
    ) = Unit

    override fun unregisterOnSharedPreferenceChangeListener(
        listener: SharedPreferences.OnSharedPreferenceChangeListener?
    ) = Unit

    private class Editor(
        private val values: MutableMap<String, Any?>,
        private val commitResults: ArrayDeque<Boolean>
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
            return commitResults.removeFirstOrNull() ?: true
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
