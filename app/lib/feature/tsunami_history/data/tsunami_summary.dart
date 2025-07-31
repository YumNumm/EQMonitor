import 'package:eqmonitor/core/api/eq_api.dart';
import 'package:eqmonitor/feature/tsunami_history/models/tsunami_converter.dart';
import 'package:eqmonitor/feature/tsunami_history/models/tsunami_models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tsunami_summary.g.dart';

@Riverpod(keepAlive: true)
Future<List<TsunamiEvent>> tsunamiSummary(Ref ref) async {
  final eqApi = ref.watch(eqApiProvider);
  final response = await eqApi.v2.getTsunamiSummary();

  // API型からアプリ型に変換
  return response.data.data
      .map(TsunamiConverter.fromApiGroupedByEvent)
      .toList();
}
