import 'package:assets_util/src/android/assets_util_jni.g.dart' as jni;
import 'package:assets_util/src/asset_pack_not_ready_exception.dart';
import 'package:jni/jni.dart';
import 'package:jni_flutter/jni_flutter.dart';

/// Android implementation backed by jnigen + jni_flutter Context.
class AssetsUtilAndroid {
  /// Registers this class with Flutter's plugin registrant (no-op for JNI).
  static void registerWith() {}

  static String resolveLocalPath({required String fileName}) {
    final context = androidApplicationContext.as(jni.Context.type);
    final jFileName = fileName.toJString();
    try {
      final jPath = jni.AssetsUtil.resolveLocalPath(context, jFileName);
      if (jPath == null) {
        throw StateError(
          'AssetsUtil.resolveLocalPath returned null for $fileName',
        );
      }
      return jPath.toDartString(releaseOriginal: true);
    } finally {
      jFileName.release();
      context.release();
    }
  }

  static Future<String> resolvePackRoot({required String packName}) async {
    final context = androidApplicationContext.as(jni.Context.type);
    final jPackName = packName.toJString();
    try {
      final jPath = jni.AssetsUtil.resolvePackRoot(context, jPackName);
      if (jPath == null) {
        throw AssetPackNotReadyException(
          'Asset Pack ($packName) is not available locally yet '
          '(Play Asset Delivery install-time pack not delivered).',
        );
      }
      return jPath.toDartString(releaseOriginal: true);
    } finally {
      jPackName.release();
      context.release();
    }
  }
}
