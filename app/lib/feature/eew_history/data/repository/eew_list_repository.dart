import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/eew_history/data/model/eew_list_page.dart';
import 'package:eqmonitor/feature/eew_history/data/model/eew_list_parameter.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_list_repository.g.dart';

@Riverpod(keepAlive: true)
Future<EewListRepository> eewListRepository(Ref ref) async {
  final apiClient = await ref.watch(apiClientProvider.future);
  return EewListRepository(eew: apiClient.eew);
}

class EewListRepository {
  EewListRepository({required api.EewApiClient eew}) : _eew = eew;

  final api.EewApiClient _eew;

  Future<EewListPage> fetchEewList({
    required EewListParameter parameter,
    required String? cursor,
    required int limit,
  }) async {
    final q = parameter.toQuery(cursor: cursor, limit: limit);
    final response = await _eew.getV2Eew(
      limit: q.limit,
      cursor: q.cursor,
      magnitudeGte: q.magnitudeGte,
      magnitudeLte: q.magnitudeLte,
      depthGte: q.depthGte,
      depthLte: q.depthLte,
      intensityGte: q.intensityGte,
      intensityLte: q.intensityLte,
      originTimeGte: q.originTimeGte,
      originTimeLte: q.originTimeLte,
      isWarning: q.isWarning,
    );
    return EewListPage(
      items: response.data.items.map((e) => e.toEewTelegramItem).toList(),
      nextToken: response.data.nextToken,
    );
  }
}
