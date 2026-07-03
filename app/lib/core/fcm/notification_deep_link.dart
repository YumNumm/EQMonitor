sealed class NotificationDeepLink {
  const NotificationDeepLink();

  static const _internalScheme = 'eqmonitor';
  static const _allowedPathPrefixes = [
    '/earthquake-history-details/',
    '/feed/source/',
  ];

  static NotificationDeepLink? fromData(Map<String, Object?> data) {
    final link = data['link'];
    if (link is String) {
      final uri = Uri.tryParse(link);
      if (uri != null) {
        if (uri.scheme == _internalScheme &&
            _allowedPathPrefixes.any(uri.path.startsWith)) {
          return NotificationRouteLink(
            location: Uri(
              path: uri.path,
              query: uri.hasQuery ? uri.query : null,
            ).toString(),
          );
        }
        if (uri.scheme == 'https' || uri.scheme == 'http') {
          return NotificationUrlLink(uri: uri);
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
