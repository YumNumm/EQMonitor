import 'package:eqmonitor/feature/telemetry/data/provider/telemetry_uploader_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'telemetry_startup_flush_provider.g.dart';

@Riverpod(keepAlive: true)
Future<void> telemetryStartupFlush(Ref ref) async {
  final uploader = ref.watch(telemetryUploaderProvider);
  await uploader.flush();
}
