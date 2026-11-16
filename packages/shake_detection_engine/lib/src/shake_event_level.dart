enum ShakeEventLevel {
  weaker,
  weak,
  medium,
  strong,
  stronger;

  factory fromIntensity(double? intensity) {
    if (intensity == null) {
      return weaker;
    }
    if (intensity > 4.5) {
      return stronger;
    }
    if (intensity > 2.5) {
      return strong;
    }
    if (intensity > 0.5) {
      return medium;
    }
    if (intensity > -1) {
      return weak;
    }
    return weaker;
  }
}
