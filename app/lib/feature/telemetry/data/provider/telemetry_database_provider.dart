import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:telemetry_store/telemetry_store.dart';

part 'telemetry_database_provider.g.dart';

/// MethodChannel for obtaining the iOS App Group container path.
///
/// The native side (AppDelegate.swift) resolves the real container path via
/// `FileManager.default.containerURL(forSecurityApplicationGroupIdentifier:)`,
/// which is the only reliable way to obtain this path on iOS.
const _appGroupChannel = MethodChannel('net.yumnumm.eqmonitor/app_group');

@Riverpod(keepAlive: true)
TelemetryDatabase telemetryDatabase(Ref ref) {
  final dbPath = ref.watch(telemetryDbPathProvider);
  final db = TelemetryDatabase(NativeDatabase.createInBackground(File(dbPath)));
  ref.onDispose(db.close);
  return db;
}

@Riverpod(keepAlive: true)
String telemetryDbPath(Ref ref) {
  throw UnimplementedError(
    'Must be overridden with the resolved path at startup',
  );
}

class TelemetryDbPathResolver {
  const new _();

  static Future<String> resolve() async {
    if (Platform.isIOS) {
      final containerPath = await _getAppGroupContainerPath();
      final dir = Directory(
        p.join(containerPath, 'Library', 'Application Support'),
      );
      if (!dir.existsSync()) {
        dir.createSync(recursive: true);
      }
      return p.join(dir.path, 'telemetry.db');
    }
    final appDir = await getApplicationDocumentsDirectory();
    return p.join(appDir.path, 'telemetry.db');
  }

  /// Returns the App Group container path obtained from the native side via
  /// `FileManager.default.containerURL(forSecurityApplicationGroupIdentifier:)`.
  ///
  /// This is the **only** correct way to get the App Group container path.
  /// String-manipulation heuristics on paths returned by `path_provider` are
  /// fragile and can break across iOS versions and simulator vs device.
  static Future<String> _getAppGroupContainerPath() async {
    final path = await _appGroupChannel.invokeMethod<String>(
      'getContainerPath',
    );
    if (path == null || path.isEmpty) {
      throw StateError(
        'Native getContainerPath returned null. '
        'Ensure the App Group entitlement is configured correctly.',
      );
    }
    return path;
  }
}
