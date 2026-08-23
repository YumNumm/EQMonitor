package net.yumnumm.background_location_tracker

import android.content.Context
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.embedding.engine.loader.FlutterLoader
import io.flutter.plugin.common.MethodChannel
import io.flutter.view.FlutterCallbackInformation

/// アプリがkilled状態から位置情報BroadcastReceiverで起動した時に
/// Headless FlutterEngineを起動してDartコードを実行するクラス。
internal class LocationHeadlessRunner(private val context: Context) {
    companion object {
        private const val HEADLESS_CHANNEL = "background_location_tracker/headless"
    }

    fun start(location: StoredPendingLocation) {
        val prefs = context.getSharedPreferences(
            BackgroundLocationStorageKeys.PREFERENCES_NAME,
            Context.MODE_PRIVATE
        )

        val handle = prefs.getLong(BackgroundLocationStorageKeys.CALLBACK_HANDLE, 0L)
        if (handle == 0L) return

        val loader = FlutterLoader()
        loader.startInitialization(context)
        loader.ensureInitializationComplete(context, arrayOf())

        val callbackInfo =
            FlutterCallbackInformation.lookupCallbackInformation(handle) ?: return

        val engine = FlutterEngine(context)
        engine.dartExecutor.executeDartCallback(
            DartExecutor.DartCallback(
                context.assets,
                loader.findAppBundlePath(),
                callbackInfo
            )
        )

        val channel = MethodChannel(engine.dartExecutor.binaryMessenger, HEADLESS_CHANNEL)
        channel.setMethodCallHandler { call, result ->
            if (call.method == "ready") {
                channel.invokeMethod(
                    "onLocationUpdate",
                    mapOf(
                        "updateId" to location.updateId,
                        "latitude" to location.latitude,
                        "longitude" to location.longitude,
                        "accuracy" to location.accuracy,
                        "timestampMillis" to location.timestampMillis
                    )
                )
                result.success(null)
            }
        }
    }
}
