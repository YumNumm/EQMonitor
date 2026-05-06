import 'package:eqmonitor/feature/earthquake_history/data/model/current_location_intensity_display.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'current_location_intensity_provider.g.dart';

@riverpod
Future<CurrentLocationIntensityDisplay> currentLocationIntensity(
  Ref ref, {
  required String eventId,
  required String? cityAreaCode,
  required String? regionAreaCode,
}) async {
  if (cityAreaCode == null && regionAreaCode == null) {
    return const CurrentLocationIntensityDisplay.none();
  }

  final earthquake = await ref.watch(
    earthquakeHistoryDetailsProvider(eventId).future,
  );
  final intensity = earthquake.intensity;
  if (intensity == null) {
    return const CurrentLocationIntensityDisplay.none();
  }

  final repository = await ref.watch(
    earthquakeHistoryRepositoryProvider.future,
  );
  return repository.resolveCurrentLocationIntensity(
    regions: intensity.regions,
    intensityTree: intensity.intensityTree,
    lpgmIntensityTree: intensity.lpgmIntensityTree,
    cityAreaCode: cityAreaCode,
    regionAreaCode: regionAreaCode,
  );
}
