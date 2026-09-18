package net.yumnumm.background_location_tracker

import android.annotation.SuppressLint
import android.content.Context
import java.io.ByteArrayInputStream
import java.io.ByteArrayOutputStream
import java.io.DataInputStream
import java.io.DataOutputStream
import java.util.UUID

internal object BackgroundLocationStorageKeys {
    const val PREFERENCES_NAME = "blt_prefs"
    const val CALLBACK_HANDLE = "callback_handle"
    const val PENDING_RECORD = "pending_record_v2"

    const val LEGACY_LATITUDE_BITS = "pending_lat_bits"
    const val LEGACY_LONGITUDE_BITS = "pending_lon_bits"
    const val LEGACY_TIMESTAMP_MILLIS = "pending_ts"

    const val ROUND_ZERO_UPDATE_ID = "pending_update_id"
    const val ROUND_ZERO_LATITUDE_BITS = "pending_latitude_bits"
    const val ROUND_ZERO_LONGITUDE_BITS = "pending_longitude_bits"
    const val ROUND_ZERO_ACCURACY_BITS = "pending_accuracy_bits"
    const val ROUND_ZERO_TIMESTAMP_MILLIS = "pending_timestamp_millis"
    const val ROUND_ZERO_DEVICE_LOCATION_PENDING = "pending_device_location"
    const val ROUND_ZERO_APP_EFFECTS_PENDING = "pending_app_effects"
}

internal data class StoredPendingLocation(
    val updateId: String,
    val latitude: Double,
    val longitude: Double,
    val accuracy: Double,
    val timestampMillis: Long
)

private data class PendingLocationRecord(
    val location: StoredPendingLocation,
    val deviceLocationPending: Boolean,
    val appEffectsPending: Boolean
)

// 永続化の成否を判定し、失敗時にprocess内mapを復元するため同期commitを使う。
@SuppressLint("ApplySharedPref", "UseKtx")
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
        val record = PendingLocationRecord(
            location = location,
            deviceLocationPending = true,
            appEffectsPending = true
        )
        val previousRawRecord = preferences.getString(
            BackgroundLocationStorageKeys.PENDING_RECORD,
            null
        )
        if (!commitRecord(record)) {
            restoreRawRecord(previousRawRecord)
            return@synchronized null
        }
        cleanupLegacyRecords()
        return@synchronized location
    }

    fun peek(consumer: Consumer): StoredPendingLocation? = synchronized(lock) {
        val record = readOrMigrateRecord() ?: return@synchronized null
        val isPending = when (consumer) {
            Consumer.DEVICE_LOCATION -> record.deviceLocationPending
            Consumer.APP_EFFECTS -> record.appEffectsPending
        }
        return@synchronized record.location.takeIf { isPending }
    }

    fun acknowledge(updateId: String, consumer: Consumer): Boolean = synchronized(lock) {
        val record = readOrMigrateRecord() ?: return@synchronized false
        if (record.location.updateId != updateId || !record.isPending(consumer)) {
            return@synchronized false
        }

        val updatedRecord = record.acknowledge(consumer)
        val previousRawRecord = preferences.getString(
            BackgroundLocationStorageKeys.PENDING_RECORD,
            null
        )
        val committed = if (updatedRecord.hasPendingConsumer) {
            commitRecord(updatedRecord)
        } else {
            preferences.edit()
                .remove(BackgroundLocationStorageKeys.PENDING_RECORD)
                .commit()
        }
        if (!committed) {
            restoreRawRecord(previousRawRecord)
            return@synchronized false
        }
        if (!updatedRecord.hasPendingConsumer) {
            cleanupLegacyRecords()
        }
        return@synchronized true
    }

    private fun readOrMigrateRecord(): PendingLocationRecord? {
        val rawRecord = preferences.getString(
            BackgroundLocationStorageKeys.PENDING_RECORD,
            null
        )
        if (rawRecord != null) {
            val record = PendingLocationRecordCodec.decode(rawRecord)
            if (record != null && record.isValid && record.hasPendingConsumer) {
                cleanupLegacyRecords()
                return record
            }
            removeRawRecord()
        }
        return migrateRoundZeroRecord() ?: migrateLegacyRecord()
    }

    private fun migrateRoundZeroRecord(): PendingLocationRecord? {
        if (roundZeroKeys.none(preferences::contains)) return null

        val updateId = preferences.getString(
            BackgroundLocationStorageKeys.ROUND_ZERO_UPDATE_ID,
            null
        )
        val hasRequiredValues = roundZeroRequiredKeys.all(preferences::contains)
        if (updateId.isNullOrEmpty() || !hasRequiredValues) {
            cleanupKeys(roundZeroKeys)
            return null
        }
        val record = PendingLocationRecord(
            location = StoredPendingLocation(
                updateId = updateId,
                latitude = java.lang.Double.longBitsToDouble(
                    preferences.getLong(
                        BackgroundLocationStorageKeys.ROUND_ZERO_LATITUDE_BITS,
                        0L
                    )
                ),
                longitude = java.lang.Double.longBitsToDouble(
                    preferences.getLong(
                        BackgroundLocationStorageKeys.ROUND_ZERO_LONGITUDE_BITS,
                        0L
                    )
                ),
                accuracy = java.lang.Double.longBitsToDouble(
                    preferences.getLong(
                        BackgroundLocationStorageKeys.ROUND_ZERO_ACCURACY_BITS,
                        0L
                    )
                ),
                timestampMillis = preferences.getLong(
                    BackgroundLocationStorageKeys.ROUND_ZERO_TIMESTAMP_MILLIS,
                    0L
                )
            ),
            deviceLocationPending = preferences.getBoolean(
                BackgroundLocationStorageKeys.ROUND_ZERO_DEVICE_LOCATION_PENDING,
                false
            ),
            appEffectsPending = preferences.getBoolean(
                BackgroundLocationStorageKeys.ROUND_ZERO_APP_EFFECTS_PENDING,
                false
            )
        )
        if (!record.isValid || !record.hasPendingConsumer) {
            cleanupKeys(roundZeroKeys)
            return null
        }
        if (!commitRecord(record)) {
            restoreRawRecord(null)
            return null
        }
        cleanupKeys(roundZeroKeys)
        return record
    }

    private fun migrateLegacyRecord(): PendingLocationRecord? {
        if (legacyKeys.none(preferences::contains)) return null
        if (!legacyKeys.all(preferences::contains)) {
            cleanupKeys(legacyKeys)
            return null
        }
        val record = PendingLocationRecord(
            location = StoredPendingLocation(
                updateId = updateIdProvider(),
                latitude = java.lang.Double.longBitsToDouble(
                    preferences.getLong(BackgroundLocationStorageKeys.LEGACY_LATITUDE_BITS, 0L)
                ),
                longitude = java.lang.Double.longBitsToDouble(
                    preferences.getLong(BackgroundLocationStorageKeys.LEGACY_LONGITUDE_BITS, 0L)
                ),
                accuracy = 0.0,
                timestampMillis = preferences.getLong(
                    BackgroundLocationStorageKeys.LEGACY_TIMESTAMP_MILLIS,
                    0L
                )
            ),
            deviceLocationPending = true,
            appEffectsPending = true
        )
        if (!record.isValid) {
            cleanupKeys(legacyKeys)
            return null
        }
        if (!commitRecord(record)) {
            restoreRawRecord(null)
            return null
        }
        cleanupKeys(legacyKeys)
        return record
    }

    private fun commitRecord(record: PendingLocationRecord): Boolean = preferences.edit()
        .putString(
            BackgroundLocationStorageKeys.PENDING_RECORD,
            PendingLocationRecordCodec.encode(record)
        )
        .commit()

    private fun restoreRawRecord(rawRecord: String?) {
        val editor = preferences.edit()
        if (rawRecord == null) {
            editor.remove(BackgroundLocationStorageKeys.PENDING_RECORD)
        } else {
            editor.putString(BackgroundLocationStorageKeys.PENDING_RECORD, rawRecord)
        }
        editor.apply()
    }

    private fun removeRawRecord() {
        val editor = preferences.edit()
            .remove(BackgroundLocationStorageKeys.PENDING_RECORD)
        if (!editor.commit()) {
            preferences.edit()
                .remove(BackgroundLocationStorageKeys.PENDING_RECORD)
                .apply()
        }
    }

    private fun cleanupLegacyRecords() {
        cleanupKeys(roundZeroKeys + legacyKeys)
    }

    private fun cleanupKeys(keys: List<String>) {
        if (keys.none(preferences::contains)) return
        val editor = preferences.edit()
        keys.forEach(editor::remove)
        if (!editor.commit()) {
            val retryEditor = preferences.edit()
            keys.forEach(retryEditor::remove)
            retryEditor.apply()
        }
    }

    private val PendingLocationRecord.hasPendingConsumer: Boolean
        get() = deviceLocationPending || appEffectsPending

    private val PendingLocationRecord.isValid: Boolean
        get() = location.updateId.isNotEmpty() &&
            location.latitude.isFinite() &&
            location.longitude.isFinite() &&
            location.accuracy.isFinite() &&
            location.timestampMillis > 0

    private fun PendingLocationRecord.isPending(consumer: Consumer): Boolean = when (consumer) {
        Consumer.DEVICE_LOCATION -> deviceLocationPending
        Consumer.APP_EFFECTS -> appEffectsPending
    }

    private fun PendingLocationRecord.acknowledge(consumer: Consumer): PendingLocationRecord =
        when (consumer) {
            Consumer.DEVICE_LOCATION -> copy(deviceLocationPending = false)
            Consumer.APP_EFFECTS -> copy(appEffectsPending = false)
        }

    private companion object {
        val lock = Any()
        val legacyKeys = listOf(
            BackgroundLocationStorageKeys.LEGACY_LATITUDE_BITS,
            BackgroundLocationStorageKeys.LEGACY_LONGITUDE_BITS,
            BackgroundLocationStorageKeys.LEGACY_TIMESTAMP_MILLIS
        )
        val roundZeroRequiredKeys = listOf(
            BackgroundLocationStorageKeys.ROUND_ZERO_LATITUDE_BITS,
            BackgroundLocationStorageKeys.ROUND_ZERO_LONGITUDE_BITS,
            BackgroundLocationStorageKeys.ROUND_ZERO_ACCURACY_BITS,
            BackgroundLocationStorageKeys.ROUND_ZERO_TIMESTAMP_MILLIS,
            BackgroundLocationStorageKeys.ROUND_ZERO_DEVICE_LOCATION_PENDING,
            BackgroundLocationStorageKeys.ROUND_ZERO_APP_EFFECTS_PENDING
        )
        val roundZeroKeys = roundZeroRequiredKeys +
            BackgroundLocationStorageKeys.ROUND_ZERO_UPDATE_ID
    }
}

private object PendingLocationRecordCodec {
    private const val VERSION = 1
    private const val HEX_DIGITS = "0123456789abcdef"

    fun encode(record: PendingLocationRecord): String {
        val bytes = ByteArrayOutputStream().use { output ->
            DataOutputStream(output).use { data ->
                data.writeInt(VERSION)
                data.writeUTF(record.location.updateId)
                data.writeDouble(record.location.latitude)
                data.writeDouble(record.location.longitude)
                data.writeDouble(record.location.accuracy)
                data.writeLong(record.location.timestampMillis)
                data.writeBoolean(record.deviceLocationPending)
                data.writeBoolean(record.appEffectsPending)
            }
            output.toByteArray()
        }
        return buildString(bytes.size * 2) {
            bytes.forEach { byte ->
                val value = byte.toInt() and 0xff
                append(HEX_DIGITS[value ushr 4])
                append(HEX_DIGITS[value and 0x0f])
            }
        }
    }

    fun decode(rawRecord: String): PendingLocationRecord? = runCatching {
        if (rawRecord.length % 2 != 0) return@runCatching null
        val bytes = ByteArray(rawRecord.length / 2) { index ->
            val high = rawRecord[index * 2].digitToInt(16)
            val low = rawRecord[index * 2 + 1].digitToInt(16)
            ((high shl 4) or low).toByte()
        }
        DataInputStream(ByteArrayInputStream(bytes)).use { data ->
            if (data.readInt() != VERSION) return@runCatching null
            val record = PendingLocationRecord(
                location = StoredPendingLocation(
                    updateId = data.readUTF(),
                    latitude = data.readDouble(),
                    longitude = data.readDouble(),
                    accuracy = data.readDouble(),
                    timestampMillis = data.readLong()
                ),
                deviceLocationPending = data.readBoolean(),
                appEffectsPending = data.readBoolean()
            )
            if (data.available() != 0) null else record
        }
    }.getOrNull()
}
