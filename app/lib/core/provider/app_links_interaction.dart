import 'package:app_links/app_links.dart';
import 'package:eqmonitor/core/fcm/notification_deep_link.dart';
import 'package:eqmonitor/core/provider/app_links_cold_start_gate.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'app_links_interaction.g.dart';

final AppLinksColdStartGate _appLinksColdStartGate = AppLinksColdStartGate();

NotificationDeepLink? consumePendingAppLink() =>
    _appLinksColdStartGate.consumePending();

Future<void> awaitInitialAppLinkResolved() =>
    _appLinksColdStartGate.whenResolved;

@Riverpod(keepAlive: true)
Stream<Uri> appLinksInteraction(Ref ref) async* {
  final appLinks = AppLinks();

  // Cold-start: store initial link as pending so splash_page can consume it
  // after routing is ready, matching the firebase_messaging_interaction pattern.
  //
  // On iOS UIScene, the native plugin must support scene lifecycle (app_links
  // 7+) or getInitialLink stays null for widget / custom-scheme cold starts.
  Uri? initialUri;
  try {
    initialUri = await appLinks.getInitialLink();
  } finally {
    // Splash awaits this; always complete even when getInitialLink throws.
    _appLinksColdStartGate.resolveInitial(initialUri);
  }
  if (initialUri != null) {
    yield initialUri;
  }

  await for (final uri in appLinks.uriLinkStream) {
    if (!_appLinksColdStartGate.shouldNavigateForStreamUri(uri)) {
      continue;
    }
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
