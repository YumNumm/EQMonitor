import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:intl/intl.dart';
import 'package:paging_view/paging_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tsunami_history_data_source.g.dart';

@riverpod
Future<TsunamiHistoryDataSource> tsunamiHistoryDataSource(Ref ref) async {
  final client = await ref.read(apiClientProvider.future);
  final dataSource = TsunamiHistoryDataSource(client: client);
  ref.onDispose(dataSource.dispose);
  return dataSource;
}

class TsunamiHistoryDataSource
    extends GroupedDataSource<String?, String, api.TsunamiState> {
  new({required api.ApiClient client}) : _client = client;

  final api.ApiClient _client;

  static final _dateFormatter = DateFormat('yyyy/MM/dd');

  @override
  String groupBy(api.TsunamiState value) {
    return _dateFormatter.format(value.updatedAt.toLocal());
  }

  @override
  Future<LoadResult<String?, api.TsunamiState>> load(
    LoadAction<String?> action,
  ) async => switch (action) {
    Refresh() => await _fetch(null),
    Append(:final key) => await _fetch(key),
    Prepend() => const None(),
  };

  Future<LoadResult<String?, api.TsunamiState>> _fetch(
    String? cursor,
  ) async {
    try {
      final limit = cursor != null ? 50 : 20;
      final response = await _client.tsunami.getV2Tsunami(
        limit: limit.toString(),
        cursor: cursor,
      );
      return Success(
        page: PageData(
          data: response.data.items,
          appendKey: response.data.nextToken,
        ),
      );
    } on Exception catch (e, st) {
      return Failure(error: e, stackTrace: st);
    }
  }
}
