import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/feature/earthquake_history_early/data/earthquake_history_early_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_history_early_details_notifier.g.dart';

@riverpod
Future<EarthquakeEarlyEvent> earthquakeHistoryEarlyEvent(
  EarthquakeHistoryEarlyEventRef ref,
  String id,
) =>
    ref
        .watch(earthquakeHistoryEarlyRepositoryProvider)
        .fetchEarthquakeEarlyEvent(
          id: id,
        );
