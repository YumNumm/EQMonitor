package net.yumnumm.assets_util

import io.flutter.embedding.engine.plugins.FlutterPlugin

/** Registers the Android library so Kotlin classes ship in the app APK. */
class AssetsUtilPlugin : FlutterPlugin {
  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    // Context is provided by jni_flutter's JniFlutterPlugin.
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
  }
}
