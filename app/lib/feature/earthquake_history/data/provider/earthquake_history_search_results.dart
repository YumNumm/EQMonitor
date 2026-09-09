import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_search_result.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/earthquake_region_search.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_search_results.g.dart';

@riverpod
Future<List<EarthquakeHistorySearchResult>> earthquakeHistorySearchResults(
  Ref ref,
  String query,
) async {
  if (query.trim().isEmpty) {
    return const [];
  }
  final parameters = await ref.watch(parameterSetProvider.future);
  return ref
      .watch(earthquakeRegionSearchProvider)
      .search(
        parameter: parameters.earthquake,
        query: query,
      );
}
