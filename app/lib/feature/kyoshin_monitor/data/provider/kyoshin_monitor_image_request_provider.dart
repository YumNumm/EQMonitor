import 'package:eqmonitor/feature/kyoshin_monitor/data/logic/kyoshin_monitor_image_request_resolver.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_image_request.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_image_request_provider.g.dart';

@Riverpod(keepAlive: true)
KyoshinMonitorImageRequest kyoshinMonitorImageRequest(Ref ref) {
  final settings = ref.watch(kyoshinMonitorSettingsProvider).requireValue;
  return ref
      .watch(kyoshinMonitorImageRequestResolverProvider)
      .resolve(settings);
}
