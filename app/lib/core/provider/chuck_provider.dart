import 'package:chuck_interceptor/chuck_interceptor.dart';
import 'package:eqmonitor/app.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chuck_provider.g.dart';

@Riverpod(keepAlive: true)
Chuck chuck(Ref ref) {
  return Chuck(navigatorKey: App.navigatorKey, showNotification: true);
}
