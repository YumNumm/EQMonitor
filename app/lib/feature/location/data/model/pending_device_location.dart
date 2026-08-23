class PendingDeviceLocation {
  const new({
    required this.updateId,
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.timestampMillis,
  });

  final String updateId;
  final double latitude;
  final double longitude;
  final double accuracy;
  final int timestampMillis;
}
