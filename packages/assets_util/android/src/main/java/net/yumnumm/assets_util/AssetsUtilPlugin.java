package net.yumnumm.assets_util;

import io.flutter.embedding.engine.plugins.FlutterPlugin;

/** Registers the Android library so Java classes ship in the app APK. */
public final class AssetsUtilPlugin implements FlutterPlugin {
  @Override
  public void onAttachedToEngine(FlutterPluginBinding binding) {
    // Context is provided by jni_flutter's JniFlutterPlugin.
  }

  @Override
  public void onDetachedFromEngine(FlutterPluginBinding binding) {}
}
