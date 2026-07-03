import 'dart:convert';

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_data_source.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/feature/settings/features/home_widget_settings/data/model/widget_region_selection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'widget_region_notifier.g.dart';

/// ホーム画面ウィジェットの「任意地域」表示に使う地域選択を永続化する。
///
/// 未選択のときは null。Pro 専用機能だが、解約後も設定自体は保持し、
/// 再購読時にそのまま復元できるようにする（App Group への反映は writer 側で
/// isPro に応じてガードする）。
@Riverpod(keepAlive: true)
class WidgetRegionNotifier extends _$WidgetRegionNotifier {
  @override
  Future<WidgetRegionSelection?> build() async {
    final dataSource = await ref.read(sharedPreferencesDataSourceProvider.future);
    final jsonString = await dataSource.getString(
      key: SharedPreferencesKey.widgetRegionSelection,
    );
    if (jsonString == null) {
      return null;
    }
    try {
      return WidgetRegionSelection.fromJson(
        jsonDecode(jsonString) as Map<String, dynamic>,
      );
      // 壊れた/旧形式のデータは復旧不能なため未選択として扱う。
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      return null;
    }
  }

  Future<void> save(WidgetRegionSelection value) async {
    state = AsyncData(value);
    final dataSource = await ref.read(sharedPreferencesDataSourceProvider.future);
    await dataSource.setString(
      key: SharedPreferencesKey.widgetRegionSelection,
      value: jsonEncode(value.toJson()),
    );
  }

  Future<void> clear() async {
    state = const AsyncData(null);
    final dataSource = await ref.read(sharedPreferencesDataSourceProvider.future);
    await dataSource.remove(key: SharedPreferencesKey.widgetRegionSelection);
  }
}
