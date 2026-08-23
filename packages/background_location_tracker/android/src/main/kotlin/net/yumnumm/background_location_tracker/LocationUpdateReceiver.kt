package net.yumnumm.background_location_tracker

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import com.google.android.gms.location.LocationResult

/// FusedLocationProviderClientからの位置更新を受信するBroadcastReceiver。
/// アプリがkilled状態の時もここで起動する。
class LocationUpdateReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (!LocationResult.hasResult(intent)) return
        val result = LocationResult.extractResult(intent) ?: return
        val location = result.lastLocation ?: return
        val pendingLocation = PendingLocationStore(context).save(
            latitude = location.latitude,
            longitude = location.longitude,
            accuracy = location.accuracy.toDouble(),
            timestampMillis = location.time
        ) ?: return

        if (BackgroundLocationPlugin.dispatchLocationUpdate(
                pendingLocation.toPigeonMessage()
            )
        ) {
            return
        }

        LocationHeadlessRunner(context).start(pendingLocation)
    }
}
