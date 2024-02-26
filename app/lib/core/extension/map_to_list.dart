extension MapToListEx<K, V> on Map<K, V> {
  List<
      ({
        K key,
        V value,
      })> get toList => entries
      .map(
        (el) => (key: el.key, value: el.value),
      )
      .toList();
}
