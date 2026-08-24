package net.yumnumm.background_location_tracker

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import androidx.work.BackoffPolicy
import androidx.work.Constraints
import androidx.work.ExistingWorkPolicy
import androidx.work.NetworkType
import androidx.work.OneTimeWorkRequest
import androidx.work.WorkManager
import com.google.android.gms.location.LocationResult
import java.util.concurrent.TimeUnit

internal data class ReceivedLocation(
    val latitude: Double,
    val longitude: Double,
    val accuracy: Double,
    val timestampMillis: Long
)

internal class LocationUpdateHandler(
    private val save: (ReceivedLocation) -> StoredPendingLocation?,
    private val dispatch: (StoredPendingLocation) -> Unit,
    private val enqueue: () -> Unit
) {
    fun handle(location: ReceivedLocation) {
        val pendingLocation = save(location) ?: return
        try {
            dispatch(pendingLocation)
        } finally {
            enqueue()
        }
    }
}

internal fun interface UniqueWorkEnqueuer {
    fun enqueue(
        uniqueWorkName: String,
        existingWorkPolicy: ExistingWorkPolicy,
        request: OneTimeWorkRequest
    )
}

internal class PendingLocationWorkScheduler(
    private val enqueuer: UniqueWorkEnqueuer
) {
    constructor(context: Context) : this(
        enqueuer = UniqueWorkEnqueuer { name, policy, request ->
            WorkManager.getInstance(context.applicationContext)
                .enqueueUniqueWork(name, policy, request)
        }
    )

    fun enqueue() {
        enqueuer.enqueue(
            UNIQUE_WORK_NAME,
            ExistingWorkPolicy.REPLACE,
            OneTimeWorkRequest.Builder(PendingLocationWorker::class.java)
                .setConstraints(
                    Constraints.Builder()
                        .setRequiredNetworkType(NetworkType.CONNECTED)
                        .build()
                )
                .setBackoffCriteria(
                    BackoffPolicy.EXPONENTIAL,
                    BACKOFF_DELAY_SECONDS,
                    TimeUnit.SECONDS
                )
                .build()
        )
    }

    private companion object {
        const val UNIQUE_WORK_NAME = "eqmonitor-device-location-sync"
        const val BACKOFF_DELAY_SECONDS = 30L
    }
}

/// FusedLocationProviderClientからの位置更新を受信するBroadcastReceiver。
/// アプリがkilled状態の時もここで起動する。
class LocationUpdateReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (!LocationResult.hasResult(intent)) return
        val result = LocationResult.extractResult(intent) ?: return
        val location = result.lastLocation ?: return
        val pendingStore = PendingLocationStore(context)
        val handler = LocationUpdateHandler(
            save = { received ->
                pendingStore.save(
                    latitude = received.latitude,
                    longitude = received.longitude,
                    accuracy = received.accuracy,
                    timestampMillis = received.timestampMillis
                )
            },
            dispatch = { pending ->
                BackgroundLocationPlugin.dispatchLocationUpdate(
                    pending.toPigeonMessage()
                )
            },
            enqueue = PendingLocationWorkScheduler(context)::enqueue
        )
        handler.handle(
            ReceivedLocation(
                latitude = location.latitude,
                longitude = location.longitude,
                accuracy = location.accuracy.toDouble(),
                timestampMillis = location.time
            )
        )
    }
}
