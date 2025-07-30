import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/api/eq_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tsunami_summary.g.dart';

@Riverpod(keepAlive: true)
Future<TsunamiSummaryResponse> tsunamiSummary(Ref ref) async {
  final eqApi = ref.watch(eqApiProvider);
  final response = await eqApi.v1.getTsunamiSummary();
  return response.data;
}
