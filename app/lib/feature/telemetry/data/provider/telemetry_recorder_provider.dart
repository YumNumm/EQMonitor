import 'package:eqmonitor/feature/telemetry/data/provider/telemetry_database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:telemetry_store/telemetry_store.dart';

part 'telemetry_recorder_provider.g.dart';

@Riverpod(keepAlive: true)
TelemetryRecorder telemetryRecorder(Ref ref) => TelemetryRecorder(
  db: ref.watch(telemetryDatabaseProvider),
);
