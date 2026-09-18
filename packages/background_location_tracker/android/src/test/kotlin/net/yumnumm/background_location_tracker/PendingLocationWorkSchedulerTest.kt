package net.yumnumm.background_location_tracker

import androidx.work.BackoffPolicy
import androidx.work.ExistingWorkPolicy
import androidx.work.NetworkType
import androidx.work.OneTimeWorkRequest
import java.util.concurrent.TimeUnit
import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNull
import org.junit.Test

class PendingLocationWorkSchedulerTest {
    @Test
    fun enqueueUsesUniqueReplaceConnectedNetworkAndExponentialBackoff() {
        var uniqueWorkName: String? = null
        var existingWorkPolicy: ExistingWorkPolicy? = null
        var capturedRequest: OneTimeWorkRequest? = null
        val scheduler = PendingLocationWorkScheduler { name, policy, request ->
            uniqueWorkName = name
            existingWorkPolicy = policy
            capturedRequest = request
        }

        scheduler.enqueue()

        val request = requireNotNull(capturedRequest)
        assertEquals("eqmonitor-device-location-sync", uniqueWorkName)
        assertEquals(ExistingWorkPolicy.REPLACE, existingWorkPolicy)
        assertEquals(NetworkType.CONNECTED, request.workSpec.constraints.requiredNetworkType)
        assertEquals(BackoffPolicy.EXPONENTIAL, request.workSpec.backoffPolicy)
        assertEquals(
            TimeUnit.SECONDS.toMillis(30),
            request.workSpec.backoffDelayDuration
        )
        assertFalse(request.workSpec.expedited)
        assertNull(request.workSpec.constraints.requiredNetworkRequest)
    }

    @Test
    fun receiverPersistsBeforeDispatchAndAlwaysEnqueuesTheWorker() {
        val events = mutableListOf<String>()
        val handler = LocationUpdateHandler(
            save = {
                events += "save"
                StoredPendingLocation(
                    updateId = "saved",
                    latitude = 35.0,
                    longitude = 139.0,
                    accuracy = 10.0,
                    timestampMillis = 1_000L
                )
            },
            dispatch = { events += "dispatch" },
            enqueue = { events += "enqueue" }
        )

        handler.handle(
            ReceivedLocation(
                latitude = 35.0,
                longitude = 139.0,
                accuracy = 10.0,
                timestampMillis = 1_000L
            )
        )

        assertEquals(listOf("save", "dispatch", "enqueue"), events)
    }

    @Test
    fun failedPersistenceDoesNotDispatchOrEnqueue() {
        val events = mutableListOf<String>()
        val handler = LocationUpdateHandler(
            save = {
                events += "save"
                null
            },
            dispatch = { events += "dispatch" },
            enqueue = { events += "enqueue" }
        )

        handler.handle(
            ReceivedLocation(
                latitude = 35.0,
                longitude = 139.0,
                accuracy = 10.0,
                timestampMillis = 1_000L
            )
        )

        assertEquals(listOf("save"), events)
    }

    @Test
    fun foregroundServiceRequirementsCoverCurrentAndLegacyAndroidRules() {
        assertEquals(
            ForegroundServiceRequirement.NONE,
            PendingLocationWorkerPolicy.foregroundServiceRequirement(
                sdkInt = 29,
                timeoutMillis = PendingLocationWorkerPolicy.WORKER_TIMEOUT_MILLIS
            )
        )
        assertEquals(
            ForegroundServiceRequirement.NONE,
            PendingLocationWorkerPolicy.foregroundServiceRequirement(
                sdkInt = 36,
                timeoutMillis = PendingLocationWorkerPolicy.WORKER_TIMEOUT_MILLIS
            )
        )
        assertEquals(
            ForegroundServiceRequirement.BASE_PERMISSION,
            PendingLocationWorkerPolicy.foregroundServiceRequirement(
                sdkInt = 33,
                timeoutMillis = TimeUnit.MINUTES.toMillis(10)
            )
        )
        assertEquals(
            ForegroundServiceRequirement.DATA_SYNC_TYPE,
            PendingLocationWorkerPolicy.foregroundServiceRequirement(
                sdkInt = 34,
                timeoutMillis = TimeUnit.MINUTES.toMillis(10)
            )
        )
    }
}
