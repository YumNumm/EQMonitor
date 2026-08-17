final class NotificationRegionSelection {
  const new({
    required this.regionCode,
    required this.regionName,
    this.cityCode,
    this.cityName,
  });

  final String regionCode;
  final String regionName;
  final String? cityCode;
  final String? cityName;
}
