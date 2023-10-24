import 'dart:convert';

import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'kmoni_view_settings.freezed.dart';
part 'kmoni_view_settings.g.dart';

@freezed
class KmoniSettingsState with _$KmoniSettingsState {
  const factory KmoniSettingsState({
    // 設定
    /// 震度0以上のみ表示するかどうか
    /// 震度0-1: グレーで表示
    /// 震度1-: isShowIntensityIcon が true の場合はアイコンを表示
    /// 震度1-: isShowIntensityIcon が false の場合は色で表示
    @Default(false) bool isUpper0Only,

    /// 震度アイコンを表示するかどうか
    @Default(false) bool isShowIntensityIcon,

    /// 強震モニタを使用するかどうか
    @Default(false) bool useKmoni,
  }) = _KmoniSettingsState;

  factory KmoniSettingsState.fromJson(Map<String, dynamic> json) =>
      _$KmoniSettingsStateFromJson(json);
}

@Riverpod(keepAlive: true)
class KmoniSettings extends _$KmoniSettings {
  @override
  KmoniSettingsState build() {
    _prefs = ref.watch(sharedPreferencesProvider);
    ref.listenSelf((_, __) => _save());
    final result = _loadFromPrefs();
    if (result != null) {
      return result;
    }

    return const KmoniSettingsState();
  }

  static const _prefsKey = '_kmoni_settings';
  late final SharedPreferences _prefs;

  KmoniSettingsState? _loadFromPrefs() {
    final json = _prefs.getString(_prefsKey);
    if (json == null) {
      return null;
    }
    try {
      return KmoniSettingsState.fromJson(
        jsonDecode(json) as Map<String, dynamic>,
      );
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      return null;
    }
  }

  Future<void> _save() async {
    await _prefs.setString(
      _prefsKey,
      jsonEncode(state.toJson()),
    );
  }

  void toggleIsUpper0Only() {
    state = state.copyWith(
      isUpper0Only: !state.isUpper0Only,
    );
  }

  void toggleIsShowIntensityIcon() {
    state = state.copyWith(
      isShowIntensityIcon: !state.isShowIntensityIcon,
    );
  }

  void toggleUseKmoni() {
    state = state.copyWith(
      useKmoni: !state.useKmoni,
    );
  }

  void setUseKmoni({required bool value}) {
    state = state.copyWith(
      useKmoni: value,
    );
  }
}
