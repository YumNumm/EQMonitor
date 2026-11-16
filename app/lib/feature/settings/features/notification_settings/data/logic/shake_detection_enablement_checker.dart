import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';

final class const ShakeDetectionEnablementChecker() {
  bool enablesAny({
    required List<ShakeDetectionEntry> previous,
    required List<ShakeDetectionEntry> next,
  }) => next.any(
    (entry) =>
        entry.enabled &&
        !previous.any((before) => before.id == entry.id && before.enabled),
  );
}
