package net.yumnumm.eqmonitor

import android.app.Activity
import android.content.Context
import android.content.SharedPreferences
import android.os.UserManager

/** Flutter の SharedPreferencesDataSource と同じ保存値を起動前から使用する。 */
class ScreenBehaviorPreferences(private val activity: Activity) :
    SharedPreferences.OnSharedPreferenceChangeListener {
    private var preferences: SharedPreferences? = null

    fun restore() {
        // directBootAware の Activity は credential protected storage を開けない場合がある。
        val unlocked = activity.getSystemService(UserManager::class.java)?.isUserUnlocked == true
        if (!unlocked) {
            apply(false)
            return
        }
        val store = preferences ?: activity.getSharedPreferences(
            PREFERENCES_NAME,
            Context.MODE_PRIVATE,
        ).also {
            preferences = it
            it.registerOnSharedPreferenceChangeListener(this)
        }
        apply(store.getBoolean(SHOW_WHEN_LOCKED, true))
    }

    override fun onSharedPreferenceChanged(store: SharedPreferences, key: String?) {
        if (key == SHOW_WHEN_LOCKED || key == null) {
            apply(store.getBoolean(SHOW_WHEN_LOCKED, true))
        }
    }

    fun dispose() {
        preferences?.unregisterOnSharedPreferenceChangeListener(this)
        preferences = null
    }

    private fun apply(enabled: Boolean) {
        activity.setTurnScreenOn(enabled)
        activity.setShowWhenLocked(enabled)
    }

    companion object {
        // shared_preferences_android の legacy SharedPreferences.getInstance() の保存形式。
        private const val PREFERENCES_NAME = "FlutterSharedPreferences"
        // SharedPreferencesKey.showWhenLocked と一致させる。Dart 側だけが書き込む。
        private const val SHOW_WHEN_LOCKED = "flutter.show_when_locked"
    }
}
