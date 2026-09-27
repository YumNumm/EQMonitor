final class const EarthquakeDeletedException({required final String eventId})
    implements Exception {
  @override
  String toString() => 'この地震情報は削除され、利用できなくなりました。';
}
