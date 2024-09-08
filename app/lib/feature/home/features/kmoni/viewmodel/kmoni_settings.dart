import 'dart:convert';

import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kmoni_settings.freezed.dart';
part 'kmoni_settings.g.dart';

@freezed
class KmoniSettingsState with _$KmoniSettingsState {
  const factory KmoniSettingsState({
    /// 強震モニタの表示最低リアルタイム震度
    @Default(null) double? minRealtimeShindo,

    /// スケールを表示するかどうか
    @Default(true) bool showRealtimeShindoScale,

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
    ref.listenSelf((_, __) => _save());
    final result = _loadFromPrefs();
    if (result != null) {
      return result;
    }

    return const KmoniSettingsState();
  }

  static const _prefsKey = '_kmoni_settings';

  KmoniSettingsState? _loadFromPrefs() {
    final json = ref.read(sharedPreferencesProvider).getString(_prefsKey);
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

  Future<void> _save() async => ref.read(sharedPreferencesProvider).setString(
        _prefsKey,
        jsonEncode(state.toJson()),
      );

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

  void setMinRealtimeShindo({required double? value}) {
    state = state.copyWith(
      minRealtimeShindo: value,
    );
  }

  void setShowRealtimeShindoScale({required bool value}) {
    state = state.copyWith(
      showRealtimeShindoScale: value,
    );
  }
}
