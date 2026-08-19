import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_analysis_progress.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_api_exception.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_bounds.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/seismicity/data/repository/hypocenter_analysis_repository.dart';

class HypocenterAnalysisLoader {
  const new({
    required HypocenterArchiveEventRepository repository,
  }) : _repository = repository;

  final HypocenterArchiveEventRepository _repository;

  Future<Result<List<SeismicityEvent>, HypocenterApiException>> load({
    required List<HypocenterArchive> archives,
    required SeismicityBounds bounds,
    required CancelToken cancelToken,
    void Function(HypocenterAnalysisProgress progress)? onProgress,
  }) async {
    final eventsById = <String, SeismicityEvent>{};
    final fetchedEventsByArchive = <HypocenterArchive, int>{};
    var completed = 0;
    for (var index = 0; index < archives.length; index += 2) {
      if (cancelToken.isCancelled) {
        return const Failure(
          HypocenterApiException(message: '震源分析データの取得を中止しました'),
        );
      }
      final end = (index + 2).clamp(0, archives.length);
      final results = await Future.wait(
        archives
            .sublist(index, end)
            .map(
              (archive) => _repository.fetchArchive(
                archive: archive,
                bounds: bounds,
                cancelToken: cancelToken,
                onProgress: ({required fetchedEvents}) {
                  fetchedEventsByArchive[archive] = fetchedEvents;
                  onProgress?.call(
                    HypocenterAnalysisProgress(
                      completedArchives: completed,
                      totalArchives: archives.length,
                      fetchedEvents: fetchedEventsByArchive.values.fold(
                        0,
                        (sum, value) => sum + value,
                      ),
                    ),
                  );
                },
              ),
            ),
      );
      for (final result in results) {
        switch (result) {
          case Success(:final value):
            for (final event in value) {
              eventsById[event.eventId] = event;
            }
            completed++;
            onProgress?.call(
              HypocenterAnalysisProgress(
                completedArchives: completed,
                totalArchives: archives.length,
                fetchedEvents: fetchedEventsByArchive.values.fold(
                  0,
                  (sum, value) => sum + value,
                ),
              ),
            );
          case Failure(:final exception, :final stackTrace):
            return Failure(exception, stackTrace);
        }
      }
    }
    return Success(eventsById.values.toList());
  }
}
