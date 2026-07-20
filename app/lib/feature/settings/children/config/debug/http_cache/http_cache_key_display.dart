class HttpCacheKeyDisplay {
  const HttpCacheKeyDisplay();

  String urlLabel({required String key}) {
    final first = key.indexOf(':');
    if (first < 0) {
      return key;
    }
    final second = key.indexOf(':', first + 1);
    if (second < 0) {
      return key;
    }
    final url = key.substring(second + 1);
    return url.isEmpty ? key : url;
  }
}
