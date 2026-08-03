import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/realtime/model/realtime_event.dart';
import 'package:eqmonitor/core/realtime/realtime_event_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_activity_dataset.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_activity_query.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_activity_repository.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_activity_provider.g.dart';

@riverpod
Future<EarthquakeActivityRepository> earthquakeActivityRepository(
  Ref ref,
) async => EarthquakeActivityRepository(
  earthquakeHistoryRepository: await ref.watch(
    earthquakeHistoryRepositoryProvider.future,
  ),
);

@riverpod
class EarthquakeActivityProgress extends _$EarthquakeActivityProgress {
  @override
  int build(EarthquakeActivityQuery query) => 0;

  void update(int value) => state = value;
}

@riverpod
class EarthquakeActivity extends _$EarthquakeActivity {
  @override
  Future<EarthquakeActivityDataset> build(EarthquakeActivityQuery query) async {
    ref.listen(realtimeEventsProvider, (_, next) {
      if (next case AsyncData(:final value)) {
        switch (value) {
          case RealtimeEarthquakeUpsertEvent() ||
              RealtimeEarthquakeDeleteEvent():
            ref.invalidateSelf();
          case _:
            break;
        }
      }
    });
    final progress = ref.read(
      earthquakeActivityProgressProvider(query).notifier,
    );
    progress.update(0);
    final repository = await ref.watch(
      earthquakeActivityRepositoryProvider.future,
    );
    return repository.fetch(
      query: query,
      now: ref.read(appClockProvider.notifier).now(),
      onProgress: progress.update,
    );
  }

  void refresh() => ref.invalidateSelf();
}
