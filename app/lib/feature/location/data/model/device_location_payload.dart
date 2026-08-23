class DeviceLocationPayload {
  const new({
    required this.region,
    required this.city,
    required this.tsunamiForecastRegion,
  });

  final String region;
  final String? city;
  final String? tsunamiForecastRegion;

  Map<String, dynamic> toJson() => {
    'region': region,
    if (city case final value?) 'city': value,
    if (tsunamiForecastRegion case final value?) 'tsunamiForecastRegion': value,
  };
}
