final class const ShakeBaseline({
  /// 観測点ごとの平常時の震度。観測点と同じ順序で、不明な観測点は `null`。
  required final List<double?> values,

  /// 実測の過去フレームに基づく場合は `true`。
  /// 固定値で代用した場合は `false` とし、離島の単独検知を抑止する。
  required final bool isReliable,
}) {
  /// 過去フレームの観測点ごとの中央値（偶数個の場合は小さい側）を平常値とする。
  ///
  /// 中央値は標本1つより雑音に強く、一部のフレームが揺れの最中でも影響を受けにくい。
  /// 最小値は雑音で平常値が下に偏り、誤検知が増えるため使わない。
  factory fromFrames(List<List<double?>> frames) {
    if (frames.isEmpty) {
      throw ArgumentError.value(frames, 'frames', 'must not be empty');
    }
    final stationCount = frames.first.length;
    final values = List<double?>.filled(stationCount, null);
    final samples = <double>[];
    for (var index = 0; index < stationCount; index++) {
      samples.clear();
      for (final frame in frames) {
        final value = frame[index];
        if (value != null) {
          samples.add(value);
        }
      }
      if (samples.isEmpty) {
        continue;
      }
      samples.sort();
      values[index] = samples[(samples.length - 1) ~/ 2];
    }
    return ShakeBaseline(values: values, isReliable: true);
  }

  factory constant({required int stationCount, required double value}) =>
      ShakeBaseline(
        values: List<double?>.filled(stationCount, value),
        isReliable: false,
      );
}
