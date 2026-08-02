import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_api_exception.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_bounds.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/seismicity/data/repository/hypocenter_analysis_repository.dart';

class HypocenterAnalysisLoader {
  const HypocenterAnalysisLoader({
    required HypocenterArchiveEventRepository repository,
  }) : _repository = repository;

  final HypocenterArchiveEventRepository _repository;

  Future<Result<List<SeismicityEvent>, HypocenterApiException>> load({
    required List<HypocenterArchive> archives,
    required SeismicityBounds bounds,
  }) async {
    final eventsById = <String, SeismicityEvent>{};
    for (var index = 0; index < archives.length; index += 2) {
      final end = (index + 2).clamp(0, archives.length);
      final results = await Future.wait(
        archives
            .sublist(index, end)
            .map(
              (archive) =>
                  _repository.fetchArchive(archive: archive, bounds: bounds),
            ),
      );
      for (final result in results) {
        switch (result) {
          case Success(:final value):
            for (final event in value) {
              eventsById[event.eventId] = event;
            }
          case Failure(:final exception, :final stackTrace):
            return Failure(exception, stackTrace);
        }
      }
    }
    return Success(eventsById.values.toList());
  }
}
