import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_messaging_interaction.g.dart';

@Riverpod(keepAlive: true)
Stream<RemoteMessage> firebaseMessagingInteraction(Ref ref) async* {
  final messaging = ref.watch(firebaseMessagingProvider);
  final initialMessage = await messaging.getInitialMessage();
  if (initialMessage != null) {
    yield initialMessage;
  }

  yield* FirebaseMessaging.onMessageOpenedApp;
}
