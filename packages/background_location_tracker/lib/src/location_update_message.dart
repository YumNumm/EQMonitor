@Deprecated('Use PendingLocationMessage for update ID based processing.')
class LocationUpdateMessage {
  new({
    required this.latitude,
    required this.longitude,
    required this.accuracy,
  });

  double latitude;
  double longitude;
  double accuracy;
}
