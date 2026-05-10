package net.yumnumm.background_location_tracker

import android.annotation.SuppressLint
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.os.Build
import com.google.android.gms.location.FusedLocationProviderClient
import com.google.android.gms.location.LocationRequest
import com.google.android.gms.location.LocationServices
import com.google.android.gms.location.Priority

/// FusedLocationProviderClientを使って重大な位置変化(~1km)を監視する。
/// 位置更新はLocationUpdateReceiverのBroadcastReceiverで受信する。
@SuppressLint("MissingPermission")
class SignificantLocationMonitor(private val context: Context) {
    private val fusedClient: FusedLocationProviderClient =
        LocationServices.getFusedLocationProviderClient(context)

    private val pendingIntent: PendingIntent by lazy {
        val intent = Intent(context, LocationUpdateReceiver::class.java)
        val flags = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_MUTABLE
        } else {
            PendingIntent.FLAG_UPDATE_CURRENT
        }
        PendingIntent.getBroadcast(context, 0, intent, flags)
    }

    fun start() {
        val request = LocationRequest.Builder(
            Priority.PRIORITY_BALANCED_POWER_ACCURACY,
            // 約1km移動時に更新 (significantLocationChanges相当)
            5 * 60 * 1000L // 最小5分間隔
        ).setMinUpdateDistanceMeters(1000f).build()

        fusedClient.requestLocationUpdates(request, pendingIntent)
    }

    fun stop() {
        fusedClient.removeLocationUpdates(pendingIntent)
    }
}
