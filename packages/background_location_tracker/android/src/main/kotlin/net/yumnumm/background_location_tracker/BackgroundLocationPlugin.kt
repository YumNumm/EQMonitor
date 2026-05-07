package net.yumnumm.background_location_tracker

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin

class BackgroundLocationPlugin : FlutterPlugin, BackgroundLocationHostApi {
    private var flutterApi: BackgroundLocationFlutterApi? = null
    private var context: Context? = null
    private var monitor: SignificantLocationMonitor? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        flutterApi = BackgroundLocationFlutterApi(binding.binaryMessenger)
        BackgroundLocationHostApi.setUp(binding.binaryMessenger, this)
        monitor = SignificantLocationMonitor(binding.applicationContext)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        BackgroundLocationHostApi.setUp(binding.binaryMessenger, null)
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
