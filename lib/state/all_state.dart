import 'package:eqmonitor/model/firebase/firebase_notification_status_model.dart';
import 'package:eqmonitor/model/kmoni_map_model.dart';
import 'package:eqmonitor/model/kmoni_model.dart';
import 'package:eqmonitor/notifier/firebase/firebase_notification_controller.dart';
import 'package:eqmonitor/notifier/kmoni_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifier/kmoni_map_notifier.dart';

final kmoniMapNotifier =
    StateNotifierProvider<KmoniMapNotifier, KmoniMapModel>((ref) {
  return KmoniMapNotifier();
});

final kmoniNotifier = StateNotifierProvider<KMoniNotifier, KmoniModel>((ref) {
  return KMoniNotifier();
});

/*
final kmoniMapForecastEewNotifier = StateNotifierProvider<
    KmoniMapForecastEewNotifier, Map<AreaForecastLocalEew, JmaIntensity>>(
  (ref) {
    return KmoniMapForecastEewNotifier();
  },
);
*/

// FCM Notifier
final firebaseCloudMessagingNotifier = StateNotifierProvider<
    FirebaseCloudMessagingController, FirebaseCloudMessagingModel>(
  (ref) {
    return FirebaseCloudMessagingController();
  },
);
