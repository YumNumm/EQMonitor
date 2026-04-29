import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_provider.g.dart';

@Riverpod(keepAlive: true)
Stream<List<ConnectivityResult>> connectivityStream(Ref ref) {
  return Connectivity().onConnectivityChanged;
}

@riverpod
bool isNetworkConnected(Ref ref) {
  final results = ref.watch(connectivityStreamProvider).value;
  if (results == null) {
    return true;
  }
  return results.any((r) => r != ConnectivityResult.none);
}
