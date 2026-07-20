import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_snapshot.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_snapshot_reducer.g.dart';

@Riverpod(keepAlive: true)
ShakeDetectionSnapshotReducer shakeDetectionSnapshotReducer(Ref ref) =>
    const ShakeDetectionSnapshotReducer();

class ShakeDetectionSnapshotReducer {
  const ShakeDetectionSnapshotReducer();

  ShakeDetectionSnapshot selectNewer({
    required ShakeDetectionSnapshot? current,
    required ShakeDetectionSnapshot incoming,
  }) {
    if (current == null || incoming.revision > current.revision) {
      return incoming;
    }
    return current;
  }
}
