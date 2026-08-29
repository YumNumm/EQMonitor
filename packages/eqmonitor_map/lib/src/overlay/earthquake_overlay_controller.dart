import 'package:eqmonitor_map/src/overlay/earthquake_map_overlay_snapshot.dart';
import 'package:eqmonitor_map/src/overlay/map_overlay_version_stamp.dart';

/// snapshot更新を受理した結果。
sealed class EarthquakeOverlayCommitResult {
  const EarthquakeOverlayCommitResult();
}

/// [next]が現在の描画入力として受理された結果。
final class EarthquakeOverlayCommitAccepted
    extends EarthquakeOverlayCommitResult {
  const EarthquakeOverlayCommitAccepted({required this.next});

  final EarthquakeMapOverlaySnapshot next;
}

/// [current]を維持して更新を拒否した結果。
final class EarthquakeOverlayCommitRejected
    extends EarthquakeOverlayCommitResult {
  const EarthquakeOverlayCommitRejected({required this.current});

  final EarthquakeMapOverlaySnapshot current;
}

/// data/render version規約に従い、次の完全snapshotを判定する。
EarthquakeOverlayCommitResult commitEarthquakeOverlaySnapshot({
  required EarthquakeMapOverlaySnapshot? current,
  required EarthquakeMapOverlaySnapshot next,
}) {
  if (current != null &&
      !canAdvanceMapOverlayVersionStamp(
        current: current.versionStamp,
        next: next.versionStamp,
      )) {
    return EarthquakeOverlayCommitRejected(current: current);
  }
  return EarthquakeOverlayCommitAccepted(next: next);
}

/// Rejects a separately-built input that reuses the current full version.
///
/// Exact same-version replacement is reserved for a typed GPU probe token;
/// ordinary app input must advance its version or retain the same instance.
EarthquakeOverlayCommitResult commitEarthquakeOverlayInputSnapshot({
  required EarthquakeMapOverlaySnapshot? current,
  required EarthquakeMapOverlaySnapshot next,
}) {
  if (current != null && current.versionStamp == next.versionStamp) {
    return EarthquakeOverlayCommitRejected(current: current);
  }
  return commitEarthquakeOverlaySnapshot(current: current, next: next);
}
