sealed class NotificationDeepLink {
  const NotificationDeepLink();

  static const _internalScheme = 'eqmonitor';
  // 通知(link)とOSディープリンク(app_links)は意図的に同一の許可リストを共用する。
  // 流入経路によって開ける画面が変わると契約が二重化するため。
  // `/earthquake-history` を通知 link で受けるのもこの統一の一部。
  static const _allowedPathPrefixes = [
    '/earthquake-history-details/',
    '/feed/source/',
  ];
  // Exact paths allowed as-is (no trailing segment required)
  static const _allowedExactPaths = ['/earthquake-history'];

  static NotificationDeepLink? fromUri(Uri uri) {
    if (uri.scheme == _internalScheme) {
      if (_allowedExactPaths.contains(uri.path) ||
          _allowedPathPrefixes.any(uri.path.startsWith)) {
        return NotificationRouteLink(
          location: Uri(
            path: uri.path,
            query: uri.hasQuery ? uri.query : null,
          ).toString(),
        );
      }
      return null;
    }
    if (uri.scheme == 'https' || uri.scheme == 'http') {
      return NotificationUrlLink(uri: uri);
    }
    return null;
  }

  static NotificationDeepLink? fromData(Map<String, Object?> data) {
    final link = data['link'];
    if (link is String) {
      final uri = Uri.tryParse(link);
      if (uri != null) {
        final result = fromUri(uri);
        if (result != null) {
          return result;
        }
      }
    }
    final eventId = data['eventId'];
    if (eventId is String && eventId.isNotEmpty) {
      return NotificationRouteLink(
        location: '/earthquake-history-details/$eventId',
      );
    }
    return null;
  }
}

class NotificationRouteLink extends NotificationDeepLink {
  const NotificationRouteLink({required this.location});

  final String location;
}

class NotificationUrlLink extends NotificationDeepLink {
  const NotificationUrlLink({required this.uri});

  final Uri uri;
}
