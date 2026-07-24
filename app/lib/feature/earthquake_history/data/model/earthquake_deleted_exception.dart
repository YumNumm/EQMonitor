final class EarthquakeDeletedException implements Exception {
  const EarthquakeDeletedException({required this.eventId});

  final String eventId;

  @override
  String toString() => 'この地震情報は削除され、利用できなくなりました。';
}
