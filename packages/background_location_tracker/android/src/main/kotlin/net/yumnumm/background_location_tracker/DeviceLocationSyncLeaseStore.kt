package net.yumnumm.background_location_tracker

import android.annotation.SuppressLint
import android.content.SharedPreferences
import java.util.UUID

internal data class StoredDeviceLocationSyncLease(
    val leaseId: String,
    val updateId: String
)

@SuppressLint("ApplySharedPref")
internal class DeviceLocationSyncLeaseStore(
    private val preferences: SharedPreferences,
    private val nowMillis: () -> Long = System::currentTimeMillis,
    private val leaseIdProvider: () -> String = { UUID.randomUUID().toString() }
) {
    fun acquire(updateId: String, durationMillis: Long): StoredDeviceLocationSyncLease? =
        synchronized(lock) {
            val now = nowMillis()
            if (preferences.getLong(EXPIRES_AT_MILLIS, 0L) > now) {
                return@synchronized null
            }
            val lease = StoredDeviceLocationSyncLease(
                leaseId = leaseIdProvider(),
                updateId = updateId
            )
            val committed = preferences.edit()
                .putString(LEASE_ID, lease.leaseId)
                .putString(UPDATE_ID, lease.updateId)
                .putLong(EXPIRES_AT_MILLIS, now + durationMillis)
                .commit()
            lease.takeIf { committed }
        }

    fun isOwned(leaseId: String, updateId: String): Boolean = synchronized(lock) {
        preferences.getString(LEASE_ID, null) == leaseId &&
            preferences.getString(UPDATE_ID, null) == updateId &&
            preferences.getLong(EXPIRES_AT_MILLIS, 0L) > nowMillis()
    }

    fun release(leaseId: String): Boolean = synchronized(lock) {
        if (preferences.getString(LEASE_ID, null) != leaseId) {
            return@synchronized false
        }
        preferences.edit()
            .remove(LEASE_ID)
            .remove(UPDATE_ID)
            .remove(EXPIRES_AT_MILLIS)
            .commit()
    }

    private companion object {
        val lock = Any()
        const val LEASE_ID = "device_location_sync_lease_id"
        const val UPDATE_ID = "device_location_sync_lease_update_id"
        const val EXPIRES_AT_MILLIS = "device_location_sync_lease_expires_at_millis"
    }
}
