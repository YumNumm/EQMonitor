import 'dart:io';

import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:telemetry_store/telemetry_store.dart';

part 'telemetry_database_provider.g.dart';

const _kAppGroupId = 'group.net.yumnumm.eqmonitor';

@Riverpod(keepAlive: true)
TelemetryDatabase telemetryDatabase(Ref ref) {
  final dbPath = ref.watch(telemetryDbPathProvider);
  final db = TelemetryDatabase(
    NativeDatabase.createInBackground(File(dbPath)),
  );
  ref.onDispose(db.close);
  return db;
}

@Riverpod(keepAlive: true)
String telemetryDbPath(Ref ref) {
  throw UnimplementedError(
    'Must be overridden with the resolved path at startup',
  );
}

Future<String> resolveTelemetryDbPath() async {
  if (Platform.isIOS) {
    final groupDir = await _getAppGroupDirectory();
    final dir = Directory(
      p.join(groupDir.path, 'Library', 'Application Support'),
    );
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
    }
    return p.join(dir.path, 'telemetry.db');
  }
  final appDir = await getApplicationDocumentsDirectory();
  return p.join(appDir.path, 'telemetry.db');
}

Future<Directory> _getAppGroupDirectory() async {
  if (!Platform.isIOS) {
    throw UnsupportedError('App Group is iOS-only');
  }
  // NSFileManager.containerURL(forSecurityApplicationGroupIdentifier:)
  // via path_provider's getApplicationSupportDirectory fallback.
  // On iOS, use the shared container for the App Group.
  final dir = await getApplicationSupportDirectory();
  // The App Group directory on iOS is:
  // ~/Library/Group Containers/group.net.yumnumm.eqmonitor/
  // We access it through the group container API.
  final groupPath = dir.path.replaceFirst(
    RegExp(r'/Library/Application Support$'),
    '',
  );
  final containerPath = p.join(
    Directory(groupPath).parent.parent.path,
    'Shared',
    'AppGroup',
    _kAppGroupId,
  );
  return Directory(containerPath);
}
