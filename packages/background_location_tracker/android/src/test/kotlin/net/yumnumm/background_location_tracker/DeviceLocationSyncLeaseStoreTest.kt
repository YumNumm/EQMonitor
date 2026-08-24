package net.yumnumm.background_location_tracker

import org.junit.Assert.assertEquals
import org.junit.Assert.assertFalse
import org.junit.Assert.assertNull
import org.junit.Assert.assertTrue
import org.junit.Test

class DeviceLocationSyncLeaseStoreTest {
    @Test
    fun competingEngineCannotAcquireUntilThePersistedLeaseExpires() {
        var nowMillis = 1_000L
        val leaseIds = ArrayDeque(listOf("lease-a", "lease-b"))
        val store = DeviceLocationSyncLeaseStore(
            preferences = InMemorySharedPreferences(),
            nowMillis = { nowMillis },
            leaseIdProvider = { leaseIds.removeFirst() }
        )

        val first = requireNotNull(store.acquire(updateId = "update-a", durationMillis = 500L))
        assertEquals("lease-a", first.leaseId)
        assertNull(store.acquire(updateId = "update-b", durationMillis = 500L))
        assertTrue(store.isOwned(leaseId = "lease-a", updateId = "update-a"))

        nowMillis = 1_500L
        val recovered = requireNotNull(
            store.acquire(updateId = "update-b", durationMillis = 500L)
        )
        assertEquals("lease-b", recovered.leaseId)
        assertFalse(store.isOwned(leaseId = "lease-a", updateId = "update-a"))
        assertTrue(store.isOwned(leaseId = "lease-b", updateId = "update-b"))
    }

    @Test
    fun onlyTheOwnerCanReleaseTheLease() {
        val store = DeviceLocationSyncLeaseStore(
            preferences = InMemorySharedPreferences(),
            nowMillis = { 1_000L },
            leaseIdProvider = { "lease-a" }
        )
        requireNotNull(store.acquire(updateId = "update-a", durationMillis = 500L))

        assertFalse(store.release(leaseId = "other-lease"))
        assertTrue(store.isOwned(leaseId = "lease-a", updateId = "update-a"))
        assertTrue(store.release(leaseId = "lease-a"))
        assertFalse(store.isOwned(leaseId = "lease-a", updateId = "update-a"))
    }
}
