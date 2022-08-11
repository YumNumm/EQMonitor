import 'package:eqmonitor/controller/earthquake/earthquake_controller.dart';
import 'package:eqmonitor/controller/earthquake/eew_controller.dart';
import 'package:eqmonitor/controller/firebase/firebase_notification_controller.dart';
import 'package:eqmonitor/controller/kmoni_controller.dart';
import 'package:eqmonitor/controller/kmoni_map_controller.dart';
import 'package:eqmonitor/controller/travel_time_controller.dart';
import 'package:eqmonitor/model/earthquake/earthquake_log_model.dart';
import 'package:eqmonitor/model/earthquake/eew_history_model.dart';
import 'package:eqmonitor/model/firebase/firebase_notification_status_model.dart';
import 'package:eqmonitor/model/kmoni_map_model.dart';
import 'package:eqmonitor/model/kmoni_model.dart';
import 'package:eqmonitor/model/travel_time_model.dart';
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

// 地震履歴
final earthquakeHistoryController =
    StateNotifierProvider<EarthquakeHistoryController, EarthquakeHistoryModel>(
        (ref) {
  return EarthquakeHistoryController();
});

final eewHistoryController =
    StateNotifierProvider<EewHistoryController, EewHistoryModel>((ref) {
  return EewHistoryController();
});

final travelTimeController =
    StateNotifierProvider<TravelTimeController, TravelTimeModel>((ref) {
  return TravelTimeController();
});
