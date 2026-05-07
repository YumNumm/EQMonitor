package net.yumnumm.background_location_tracker

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel

class BackgroundLocationPlugin : FlutterPlugin, BackgroundLocationHostApi {
    private var flutterApi: BackgroundLocationFlutterApi? = null
    private var context: Context? = null
    private var monitor: SignificantLocationMonitor? = null
    private var persistenceChannel: MethodChannel? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        val ctx = binding.applicationContext
        context = ctx
        flutterApi = BackgroundLocationFlutterApi(binding.binaryMessenger)
        BackgroundLocationHostApi.setUp(binding.binaryMessenger, this)
        monitor = SignificantLocationMonitor(ctx)

        // killed状態のheadless runnerが永続化した位置情報を、
        // 通常起動時にDart側が読み出すための補助チャネル。
        val channel = MethodChannel(
            binding.binaryMessenger,
            "background_location_tracker/persistence"
        )
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "consumePending" -> {
                    val prefs = ctx.getSharedPreferences("blt_prefs", Context.MODE_PRIVATE)
                    if (!prefs.contains("pending_lat_bits") ||
                        !prefs.contains("pending_lon_bits")
                    ) {
                        result.success(null)
                        return@setMethodCallHandler
                    }
                    val lat = java.lang.Double.longBitsToDouble(
                        prefs.getLong("pending_lat_bits", 0L)
                    )
                    val lon = java.lang.Double.longBitsToDouble(
                        prefs.getLong("pending_lon_bits", 0L)
                    )
                    prefs.edit()
                        .remove("pending_lat_bits")
                        .remove("pending_lon_bits")
                        .remove("pending_ts")
                        .apply()
                    result.success(mapOf("latitude" to lat, "longitude" to lon))
                }
                else -> result.notImplemented()
            }
        }
        persistenceChannel = channel
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        BackgroundLocationHostApi.setUp(binding.binaryMessenger, null)
        persistenceChannel?.setMethodCallHandler(null)
        persistenceChannel = null
        flutterApi = null
        monitor = null
        context = null
    }

    override fun initialize(callbackHandle: Long) {
        val ctx = context ?: return
        ctx.getSharedPreferences("blt_prefs", Context.MODE_PRIVATE)
            .edit()
            .putLong("callback_handle", callbackHandle)
            .apply()
    }

    override fun startMonitoring() {
        monitor?.start()
    }

    override fun stopMonitoring() {
        monitor?.stop()
    }
}
