import 'package:eqmonitor/model/kmoni_map_model.dart';
import 'package:eqmonitor/model/kmoni_model.dart';
import 'package:eqmonitor/notifier/kmoni_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../const/kmoni/jma_intensity.dart';
import '../const/prefecture/area_forecast_local_eew.model.dart';
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
