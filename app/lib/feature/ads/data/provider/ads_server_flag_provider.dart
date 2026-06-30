import 'package:eqmonitor/feature/start/data/notifier/start_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ads_server_flag_provider.g.dart';

@Riverpod(keepAlive: true)
bool adsServerFlag(Ref ref) {
  final start = ref.watch(startProvider).value;
  if (start == null) {
    return true;
  }
  return start.flags.adsEnabled;
}
