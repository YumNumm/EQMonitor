import 'package:eqmonitor/controller/earthquake/earthquake_controller.dart';
import 'package:eqmonitor/controller/earthquake/eew_controller.dart';
import 'package:eqmonitor/controller/firebase/firebase_notification_controller.dart';
import 'package:eqmonitor/controller/kmoni_controller.dart';
import 'package:eqmonitor/controller/kmoni_map_controller.dart';
import 'package:eqmonitor/controller/parameter-earthquake_controller.dart';
import 'package:eqmonitor/controller/travel_time_controller.dart';
import 'package:eqmonitor/model/earthquake/earthquake_log_model.dart';
import 'package:eqmonitor/model/earthquake/eew_history_model.dart';
import 'package:eqmonitor/model/firebase/firebase_notification_status_model.dart';
import 'package:eqmonitor/model/kmoni_map_model.dart';
import 'package:eqmonitor/model/kmoni_model.dart';
import 'package:eqmonitor/model/parameter-earthquake_model.dart';
import 'package:eqmonitor/model/travel_time_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final kmoniMapProvider =
    StateNotifierProvider<KmoniMapProvider, KmoniMapModel>((ref) {
  return KmoniMapProvider();
});

final kmoniProvider = StateNotifierProvider<KmoniProvider, KmoniModel>((ref) {
  return KmoniProvider();
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
    FirebaseCloudMessagingProvider, FirebaseCloudMessagingModel>(
  (ref) {
    return FirebaseCloudMessagingProvider();
  },
);

// 地震履歴
final earthquakeHistoryProvider =
    StateNotifierProvider<EarthquakeHistoryProvider, EarthquakeHistoryModel>(
        (ref) {
  return EarthquakeHistoryProvider();
});

final eewHistoryProvider =
    StateNotifierProvider<EewHistoryProvider, EewHistoryModel>((ref) {
  return EewHistoryProvider();
});

final travelTimeProvider =
    StateNotifierProvider<TravelTimeProvider, TravelTimeModel>((ref) {
  return TravelTimeProvider();
});

final parameterEarthquakeProvider = StateNotifierProvider<
    ParameterEarthquakeProvider, ParameterEarthquakeModel>((ref) {
  return ParameterEarthquakeProvider();
});
