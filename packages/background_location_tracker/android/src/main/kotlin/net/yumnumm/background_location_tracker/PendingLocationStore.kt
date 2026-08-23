package net.yumnumm.background_location_tracker

import android.content.Context
import java.util.UUID

internal object BackgroundLocationStorageKeys {
    const val PREFERENCES_NAME = "blt_prefs"
    const val CALLBACK_HANDLE = "callback_handle"
    const val UPDATE_ID = "pending_update_id"
    const val LATITUDE_BITS = "pending_latitude_bits"
    const val LONGITUDE_BITS = "pending_longitude_bits"
    const val ACCURACY_BITS = "pending_accuracy_bits"
    const val TIMESTAMP_MILLIS = "pending_timestamp_millis"
    const val DEVICE_LOCATION_PENDING = "pending_device_location"
    const val APP_EFFECTS_PENDING = "pending_app_effects"
}

internal data class StoredPendingLocation(
    val updateId: String,
    val latitude: Double,
    val longitude: Double,
    val accuracy: Double,
    val timestampMillis: Long
)

internal class PendingLocationStore(
    context: Context,
    private val updateIdProvider: () -> String = { UUID.randomUUID().toString() }
) {
    enum class Consumer {
        DEVICE_LOCATION,
        APP_EFFECTS
    }

    private val preferences = context.applicationContext.getSharedPreferences(
        BackgroundLocationStorageKeys.PREFERENCES_NAME,
        Context.MODE_PRIVATE
    )

    fun save(
        latitude: Double,
        longitude: Double,
        accuracy: Double,
        timestampMillis: Long
    ): StoredPendingLocation? = synchronized(lock) {
        val location = StoredPendingLocation(
            updateId = updateIdProvider(),
            latitude = latitude,
            longitude = longitude,
            accuracy = accuracy,
            timestampMillis = timestampMillis
        )
        val committed = preferences.edit()
            .putString(BackgroundLocationStorageKeys.UPDATE_ID, location.updateId)
            .putLong(
                BackgroundLocationStorageKeys.LATITUDE_BITS,
                java.lang.Double.doubleToRawLongBits(location.latitude)
            )
            .putLong(
                BackgroundLocationStorageKeys.LONGITUDE_BITS,
                java.lang.Double.doubleToRawLongBits(location.longitude)
            )
            .putLong(
                BackgroundLocationStorageKeys.ACCURACY_BITS,
                java.lang.Double.doubleToRawLongBits(location.accuracy)
            )
            .putLong(BackgroundLocationStorageKeys.TIMESTAMP_MILLIS, location.timestampMillis)
            .putBoolean(BackgroundLocationStorageKeys.DEVICE_LOCATION_PENDING, true)
            .putBoolean(BackgroundLocationStorageKeys.APP_EFFECTS_PENDING, true)
            .commit()
        if (!committed) {
            val editor = preferences.edit()
            locationKeys.forEach(editor::remove)
            editor.apply()
            return@synchronized null
        }
        return@synchronized location
    }

    fun peek(consumer: Consumer): StoredPendingLocation? = synchronized(lock) {
        if (!preferences.getBoolean(pendingKey(consumer), false)) return@synchronized null
        val updateId = preferences.getString(BackgroundLocationStorageKeys.UPDATE_ID, null)
            ?: return@synchronized null
        if (!hasAllLocationValues) return@synchronized null
        return StoredPendingLocation(
            updateId = updateId,
            latitude = java.lang.Double.longBitsToDouble(
                preferences.getLong(BackgroundLocationStorageKeys.LATITUDE_BITS, 0L)
            ),
            longitude = java.lang.Double.longBitsToDouble(
                preferences.getLong(BackgroundLocationStorageKeys.LONGITUDE_BITS, 0L)
            ),
            accuracy = java.lang.Double.longBitsToDouble(
                preferences.getLong(BackgroundLocationStorageKeys.ACCURACY_BITS, 0L)
            ),
            timestampMillis = preferences.getLong(
                BackgroundLocationStorageKeys.TIMESTAMP_MILLIS,
                0L
            )
        )
    }

    fun acknowledge(updateId: String, consumer: Consumer): Boolean = synchronized(lock) {
        val stored = peek(consumer) ?: return@synchronized false
        if (stored.updateId != updateId) return@synchronized false

        val otherConsumerPending = preferences.getBoolean(
            pendingKey(consumer.other),
            false
        )
        val editor = preferences.edit()
        if (otherConsumerPending) {
            editor.putBoolean(pendingKey(consumer), false)
        } else {
            locationKeys.forEach(editor::remove)
        }
        return editor.commit()
    }

    private val hasAllLocationValues: Boolean
        get() = requiredLocationKeys.all(preferences::contains)

    private fun pendingKey(consumer: Consumer): String = when (consumer) {
        Consumer.DEVICE_LOCATION -> BackgroundLocationStorageKeys.DEVICE_LOCATION_PENDING
        Consumer.APP_EFFECTS -> BackgroundLocationStorageKeys.APP_EFFECTS_PENDING
    }

    private val Consumer.other: Consumer
        get() = when (this) {
            Consumer.DEVICE_LOCATION -> Consumer.APP_EFFECTS
            Consumer.APP_EFFECTS -> Consumer.DEVICE_LOCATION
        }

    private companion object {
        val lock = Any()
        val requiredLocationKeys = listOf(
            BackgroundLocationStorageKeys.LATITUDE_BITS,
            BackgroundLocationStorageKeys.LONGITUDE_BITS,
            BackgroundLocationStorageKeys.ACCURACY_BITS,
            BackgroundLocationStorageKeys.TIMESTAMP_MILLIS
        )
        val locationKeys = requiredLocationKeys + listOf(
            BackgroundLocationStorageKeys.UPDATE_ID,
            BackgroundLocationStorageKeys.DEVICE_LOCATION_PENDING,
            BackgroundLocationStorageKeys.APP_EFFECTS_PENDING
        )
    }
}
