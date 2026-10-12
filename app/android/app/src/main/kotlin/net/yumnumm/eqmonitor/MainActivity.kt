package net.yumnumm.eqmonitor

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    private val screenBehaviorPreferences = ScreenBehaviorPreferences(this)

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        screenBehaviorPreferences.restore()
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
