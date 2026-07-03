import 'package:app_links/app_links.dart';
import 'package:eqmonitor/core/fcm/notification_deep_link.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'app_links_interaction.g.dart';

NotificationDeepLink? _pendingAppLink;

NotificationDeepLink? consumePendingAppLink() {
  final link = _pendingAppLink;
  _pendingAppLink = null;
  return link;
}

@Riverpod(keepAlive: true)
Stream<Uri> appLinksInteraction(Ref ref) async* {
  final appLinks = AppLinks();

  // Cold-start: store initial link as pending so splash_page can consume it
  // after routing is ready, matching the firebase_messaging_interaction pattern.
  final initialUri = await appLinks.getInitialLink();
  if (initialUri != null) {
    _pendingAppLink = NotificationDeepLink.fromUri(initialUri);
    yield initialUri;
  }

  await for (final uri in appLinks.uriLinkStream) {
    final link = NotificationDeepLink.fromUri(uri);
    switch (link) {
      case NotificationRouteLink(:final location):
        await ref.read(goRouterProvider).push(location);
      case NotificationUrlLink(:final uri):
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      case null:
        break;
    }
    yield uri;
  }
}
