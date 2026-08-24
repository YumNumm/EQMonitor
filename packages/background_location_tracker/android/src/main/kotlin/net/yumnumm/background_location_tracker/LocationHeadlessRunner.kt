package net.yumnumm.background_location_tracker

import android.content.Context
import io.flutter.FlutterInjector
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.view.FlutterCallbackInformation

internal interface ManagedHeadlessEngine {
    val bindingKey: Any

    fun registerAndExecute(
        callbackInformation: FlutterCallbackInformation,
        appBundlePath: String
    )

    fun destroy()
}

private class FlutterManagedHeadlessEngine(
    private val context: Context
) : ManagedHeadlessEngine {
    private val engine = FlutterEngine(context, emptyArray(), false)

    override val bindingKey: Any
        get() = engine.dartExecutor.binaryMessenger

    override fun registerAndExecute(
        callbackInformation: FlutterCallbackInformation,
        appBundlePath: String
    ) {
        val registrant = Class.forName(GENERATED_PLUGIN_REGISTRANT)
        val registerWith = registrant.getDeclaredMethod(
            "registerWith",
            FlutterEngine::class.java
        )
        registerWith.invoke(null, engine)
        engine.dartExecutor.executeDartCallback(
            DartExecutor.DartCallback(
                context.assets,
                appBundlePath,
                callbackInformation
            )
        )
    }

    override fun destroy() = engine.destroy()

    private companion object {
        const val GENERATED_PLUGIN_REGISTRANT =
            "io.flutter.plugins.GeneratedPluginRegistrant"
    }
}

/// WorkManagerからTask 5のDart callbackを起動する。
internal class LocationHeadlessRunner(
    private val context: Context,
    private val completionRegistry: HeadlessTaskCompletionRegistry =
        HeadlessTaskCompletionRegistry.shared,
    private val callbackHandleReader: () -> Long? = {
        val preferences = context.getSharedPreferences(
            BackgroundLocationStorageKeys.PREFERENCES_NAME,
            Context.MODE_PRIVATE
        )
        if (preferences.contains(BackgroundLocationStorageKeys.CALLBACK_HANDLE)) {
            preferences.getLong(BackgroundLocationStorageKeys.CALLBACK_HANDLE, 0L)
                .takeIf { it != 0L }
        } else {
            null
        }
    },
    private val callbackInformationReader: (Long) -> FlutterCallbackInformation? =
        FlutterCallbackInformation::lookupCallbackInformation,
    private val flutterBundleLoader: () -> String = {
        val loader = FlutterInjector.instance().flutterLoader()
        loader.startInitialization(context)
        loader.ensureInitializationComplete(context, emptyArray())
        loader.findAppBundlePath()
    },
    private val engineFactory: () -> ManagedHeadlessEngine = {
        FlutterManagedHeadlessEngine(context)
    }
) {
    fun start(
        registration: HeadlessTaskCompletionRegistry.Registration
    ): ManagedHeadlessEngine? {
        val callbackHandle = callbackHandleReader() ?: return null
        val callbackInformation = callbackInformationReader(callbackHandle) ?: return null
        val appBundlePath = flutterBundleLoader()
        val engine = engineFactory()
        if (!completionRegistry.bindEngine(registration, engine.bindingKey)) {
            engine.destroy()
            return null
        }

        try {
            engine.registerAndExecute(
                callbackInformation = callbackInformation,
                appBundlePath = appBundlePath
            )
            return engine
        } catch (error: RuntimeException) {
            completionRegistry.unbindEngine(registration, engine.bindingKey)
            engine.destroy()
            throw error
        } catch (error: ReflectiveOperationException) {
            completionRegistry.unbindEngine(registration, engine.bindingKey)
            engine.destroy()
            throw error
        }
    }
}
