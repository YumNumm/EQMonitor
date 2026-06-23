import 'package:eqmonitor/feature/telemetry/data/api_event_sender.dart';
import 'package:eqmonitor/feature/telemetry/data/provider/telemetry_database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:telemetry_store/telemetry_store.dart';

part 'telemetry_uploader_provider.g.dart';

@Riverpod(keepAlive: true)
TelemetryUploader telemetryUploader(Ref ref) => TelemetryUploader(
  db: ref.watch(telemetryDatabaseProvider),
  sender: ApiEventSender(),
);
