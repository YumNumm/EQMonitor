// ignore_for_file: avoid_classes_with_only_static_members

import 'package:eqmonitor/model/setting/developer_mode_model.dart';
import 'package:eqmonitor/provider/init/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final isDeveloperModeAllowedProvider = StateProvider<bool>((ref) => false);

final developerModeProvider =
    StateNotifierProvider<DeveloperModeNotifier, DeveloperModeModel>(
  DeveloperModeNotifier.new,
);

class DeveloperModeNotifier extends StateNotifier<DeveloperModeModel> {
  DeveloperModeNotifier(this.ref)
      : super(
          const DeveloperModeModel(isDeveloper: false),
        ) {
          _load(ref.read(sharedPreferencesProvder));
  }
  static const key = 'isDeveloperModeAllowed';

  void _load(SharedPreferences prefs){
    final isDeveloper = prefs.getBool(key) ?? false;
    state = state.copyWith(isDeveloper: isDeveloper);
  }

  bool loadIsDeveloperModeAllowed(SharedPreferences prefs) {
    return ref.read(isDeveloperModeAllowedProvider.state).state =
        prefs.getBool(key) ?? false;
  }

  Future<void> change({
    required bool isDeveloper,
  }) async {
    await ref.read(sharedPreferencesProvder).setBool(key, isDeveloper);
    ref.read(isDeveloperModeAllowedProvider.state).state = isDeveloper;
  }

  final Ref ref;
}
