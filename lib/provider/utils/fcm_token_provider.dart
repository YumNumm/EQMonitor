import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fcmTokenFutureProvider = FutureProvider<String?>(
  (ref) async => FirebaseMessaging.instance.getToken(),
);
