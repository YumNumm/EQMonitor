package net.yumnumm.eqmonitor

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    private val screenBehaviorPreferences = ScreenBehaviorPreferences(this)
    private var replayFileMethodChannel: ReplayFileMethodChannel? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        screenBehaviorPreferences.restore()
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        replayFileMethodChannel = ReplayFileMethodChannel(
            this,
            flutterEngine.dartExecutor.binaryMessenger,
        )
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        replayFileMethodChannel?.dispose()
        replayFileMethodChannel = null
        super.cleanUpFlutterEngine(flutterEngine)
    }

    override fun onResume() {
        super.onResume()
        screenBehaviorPreferences.restore()
    }

    override fun onDestroy() {
        screenBehaviorPreferences.dispose()
        super.onDestroy()
    }
}
