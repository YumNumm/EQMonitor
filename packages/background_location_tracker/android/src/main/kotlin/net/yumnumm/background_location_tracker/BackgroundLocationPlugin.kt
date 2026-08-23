package net.yumnumm.background_location_tracker

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin

class BackgroundLocationPlugin : FlutterPlugin, BackgroundLocationHostApi {
    companion object {
        @Volatile
        private var activeFlutterApi: BackgroundLocationFlutterApi? = null

        fun dispatchLocationUpdate(location: PendingLocationMessage): Boolean {
            val api = activeFlutterApi ?: return false
            api.onLocationUpdate(location) {}
            return true
        }
    }

    private var flutterApi: BackgroundLocationFlutterApi? = null
    private var context: Context? = null
    private var monitor: SignificantLocationMonitor? = null
    private var pendingStore: PendingLocationStore? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        val ctx = binding.applicationContext
        context = ctx
        flutterApi = BackgroundLocationFlutterApi(binding.binaryMessenger)
        BackgroundLocationHostApi.setUp(binding.binaryMessenger, this)
        monitor = SignificantLocationMonitor(ctx)
        pendingStore = PendingLocationStore(ctx)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        BackgroundLocationHostApi.setUp(binding.binaryMessenger, null)
        if (activeFlutterApi === flutterApi) {
            activeFlutterApi = null
        }
        flutterApi = null
        monitor = null
        pendingStore = null
        context = null
    }

    override fun initialize(callbackHandle: Long) {
        val ctx = context ?: return
        activeFlutterApi = flutterApi
        ctx.getSharedPreferences(
            BackgroundLocationStorageKeys.PREFERENCES_NAME,
            Context.MODE_PRIVATE
        )
            .edit()
            .putLong(BackgroundLocationStorageKeys.CALLBACK_HANDLE, callbackHandle)
            .apply()
    }

    override fun startMonitoring() {
        monitor?.start()
    }

    override fun stopMonitoring() {
        monitor?.stop()
    }

    override fun peekPendingLocation(
        consumer: PendingLocationConsumer
    ): PendingLocationMessage? = pendingStore
        ?.peek(consumer.storeConsumer)
        ?.toPigeonMessage()

    override fun acknowledgePendingLocation(
        updateId: String,
        consumer: PendingLocationConsumer
    ): Boolean = pendingStore?.acknowledge(updateId, consumer.storeConsumer) ?: false

    override fun getActiveHeadlessTaskId(): String? = null

    override fun completeHeadlessTask(updateId: String, result: HeadlessTaskResult) = Unit
}

private val PendingLocationConsumer.storeConsumer: PendingLocationStore.Consumer
    get() = when (this) {
        PendingLocationConsumer.DEVICE_LOCATION -> PendingLocationStore.Consumer.DEVICE_LOCATION
        PendingLocationConsumer.APP_EFFECTS -> PendingLocationStore.Consumer.APP_EFFECTS
    }

internal fun StoredPendingLocation.toPigeonMessage() = PendingLocationMessage(
    updateId = updateId,
    latitude = latitude,
    longitude = longitude,
    accuracy = accuracy,
    timestampMillis = timestampMillis
)
