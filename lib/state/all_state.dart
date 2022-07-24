import 'package:eqmonitor/controller/firebase/firebase_notification_controller.dart';
import 'package:eqmonitor/controller/kmoni_controller.dart';
import 'package:eqmonitor/controller/kmoni_map_controller.dart';
import 'package:eqmonitor/model/firebase/firebase_notification_status_model.dart';
import 'package:eqmonitor/model/kmoni_map_model.dart';
import 'package:eqmonitor/model/kmoni_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final kmoniMapController =
    StateNotifierProvider<KmoniMapController, KmoniMapModel>((ref) {
  return KmoniMapController();
});

final kmoniNotifier = StateNotifierProvider<KmoniController, KmoniModel>((ref) {
  return KmoniController();
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
