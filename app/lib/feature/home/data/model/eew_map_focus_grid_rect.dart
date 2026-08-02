class EewMapFocusGridRect {
  const EewMapFocusGridRect({
    required this.minLat,
    required this.maxLat,
    required this.minLng,
    required this.maxLng,
  });

  final double minLat;
  final double maxLat;
  final double minLng;
  final double maxLng;

  @override
  bool operator ==(Object other) =>
      other is EewMapFocusGridRect &&
      other.minLat == minLat &&
      other.maxLat == maxLat &&
      other.minLng == minLng &&
      other.maxLng == maxLng;

  @override
  int get hashCode => Object.hash(minLat, maxLat, minLng, maxLng);
}
