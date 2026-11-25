final class const JmaCoordinate({
  required final double latitude,
  required final double longitude,
  required final int? height,
  required final String? datum,
}) {
  int? get depthKilometers => switch (height) {
    null => null,
    final height => -height ~/ 1000,
  };
}
