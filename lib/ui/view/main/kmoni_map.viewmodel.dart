import 'dart:convert';

import 'package:eqmonitor/model/setting/kmoni_setting_model.dart';
import 'package:eqmonitor/provider/init/shared_preferences.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final kmoniSettingProvider =
    StateNotifierProvider<KmoniSettingNotifier, KmoniSettingModel>(
  KmoniSettingNotifier.new,
);

class KmoniSettingNotifier extends StateNotifier<KmoniSettingModel> {
  KmoniSettingNotifier(this.ref)
      : super(
          const KmoniSettingModel(),
        ) {
    _load(ref.read(sharedPreferencesProvder));
  }

  final Ref ref;

  static const prefsKey = 'kmoniSettings';

  void _load(SharedPreferences prefs) {
    final kmoniSettings = prefs.getString(prefsKey);
    if (kmoniSettings != null) {
      try {
        state = KmoniSettingModel.fromJson(jsonDecode(kmoniSettings));
        return;
        // ignore: avoid_catches_without_on_clauses
      } catch (e) {
        state = const KmoniSettingModel();
      }
    }
    state = const KmoniSettingModel();
  }

  Future<void> change({
    required Set<KmoniLayer> layers,
  }) async {
    state = state.copyWith(
      layers: layers,
    );
    await ref.read(sharedPreferencesProvder).setString(
          prefsKey,
          jsonEncode(state.toJson()),
        );
  }

  Future<void> save() async {
    await ref.read(sharedPreferencesProvder).setString(
          prefsKey,
          jsonEncode(state.toJson()),
        );
  }

  Future<void> reset() async {
    state = const KmoniSettingModel();
    await ref.read(sharedPreferencesProvder).remove(prefsKey);
    _load(ref.read(sharedPreferencesProvder));
  }
}
