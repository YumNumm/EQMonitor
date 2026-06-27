import 'package:eqmonitor/core/provider/cached_notifier.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'start_notifier.g.dart';

@Riverpod(keepAlive: true)
class StartNotifier extends _$StartNotifier
    with CachedNotifier<api.StartResponse> {
  @override
  Future<api.StartResponse> fetch(api.ApiClient client) async =>
      (await client.start.getV1Start()).data;

  @override
  Future<api.StartResponse> build() => cachedBuild();
}
