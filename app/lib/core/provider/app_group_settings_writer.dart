import 'dart:io';

import 'package:eqmonitor/core/provider/app_group_preferences.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:eqmonitor/core/provider/widget_timeline_reloader.dart';
import 'package:eqmonitor/core/provider/widget_current_location_loader.dart';
import 'package:eqmonitor/feature/location/data/jma_region_resolver.dart';
import 'package:eqmonitor/feature/settings/features/home_widget_settings/data/model/widget_region_selection.dart';
import 'package:eqmonitor/feature/settings/features/home_widget_settings/data/notifier/widget_region_notifier.dart';
import 'package:eqmonitor/feature/subscription/data/provider/is_pro_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_group_settings_writer.g.dart';

/// App Group UserDefaults のキー。Widget Extension 側と厳密に一致させる。
abstract final class AppGroupKeys {
  static const apiServerUrl = 'apiServerUrl';
  static const debugMode = 'debugMode';
  static const isPro = 'isPro';
  static const widgetRegionSearchType = 'widgetRegionSearchType';
  static const widgetRegionCode = 'widgetRegionCode';
  static const widgetRegionName = 'widgetRegionName';
  static const currentLocationRegionCode = 'currentLocationRegionCode';
  static const currentLocationRegionName = 'currentLocationRegionName';
}

/// アプリ本体の設定を iOS App Group UserDefaults へ同期する。
///
/// [telegramUrlProvider] / [isProProvider] / [widgetRegionProvider] を
/// watch するため、URL 変更・Pro 状態変化・任意地域の選択/解除が Widget に即時
/// 反映される。現在地の地域コードは位置権限が許可済みのときのみベストエフォートで
/// 書き込む（新規の権限要求はしない）。位置変化への追従は
/// `backgroundLocationService` 側で別途行う。
///
/// 書き込み内容が実際に変化したときだけ Widget のタイムライン再読み込みを要求する。
@Riverpod(keepAlive: true)
Future<void> appGroupSettingsWriter(Ref ref) async {
  if (!Platform.isIOS) {
    return;
  }

  final prefs = await ref.watch(appGroupPreferencesProvider.future);
  final telegramUrl = await ref.watch(telegramUrlProvider.future);
  final isPro = ref.watch(isProProvider);
  final widgetRegion = await ref.watch(widgetRegionProvider.future);

  var changed = false;
  changed |= await _setString(
    prefs,
    AppGroupKeys.apiServerUrl,
    telegramUrl.restApiUrl,
  );
  changed |= await _setBool(prefs, AppGroupKeys.debugMode, value: kDebugMode);
  changed |= await _setBool(prefs, AppGroupKeys.isPro, value: isPro);

  // 任意地域は Pro 専用。非 Pro のときは設定を保持したまま Widget からは隠す。
  final effectiveRegion = isPro ? widgetRegion : null;
  changed |= await _writeWidgetRegion(prefs, effectiveRegion);

  changed |= await _writeCurrentLocation(ref, prefs);

  if (changed) {
    await reloadWidgetTimelines();
  }
}

Future<bool> _writeWidgetRegion(
  SharedPreferencesAsync prefs,
  WidgetRegionSelection? region,
) async {
  if (region == null) {
    return _removeAll(prefs, const [
      AppGroupKeys.widgetRegionSearchType,
      AppGroupKeys.widgetRegionCode,
      AppGroupKeys.widgetRegionName,
    ]);
  }
  var changed = await _setString(
    prefs,
    AppGroupKeys.widgetRegionSearchType,
    region.searchType.name,
  );
  changed |= await _setString(
    prefs,
    AppGroupKeys.widgetRegionCode,
    region.code,
  );
  changed |= await _setString(
    prefs,
    AppGroupKeys.widgetRegionName,
    region.name,
  );
  return changed;
}

Future<bool> _writeCurrentLocation(
  Ref ref,
  SharedPreferencesAsync prefs,
) async {
  final result = await ref.read(widgetCurrentLocationLoaderProvider).load();
  switch (result.state) {
    case WidgetLocationState.permissionDenied:
      return writeCurrentLocationRegionToAppGroup(
        prefs,
        regionCode: null,
        regionName: null,
      );
    case WidgetLocationState.temporarilyUnavailable:
      return false;
    case WidgetLocationState.available:
      if (result.position case final position?) {
        final resolver = await ref.read(jmaRegionResolverProvider.future);
        final resolution = resolver.resolveEarthquakeRegion(
          position.latitude,
          position.longitude,
        );
        if (resolution != null) {
          return writeCurrentLocationRegionToAppGroup(
            prefs,
            regionCode: resolution.regionCode,
            regionName: resolution.regionName,
          );
        }
      }
      return false;
  }
}

/// 現在地の一次細分化地域コード/名を App Group に書き込む。
/// null のときはキーを削除する。位置変化に追従する
/// `backgroundLocationService` からも呼ばれる。
///
/// 書き込み内容が実際に変化したかを返す。呼び出し側はこれを見て
/// [reloadWidgetTimelines] を呼ぶかどうか判断する。
Future<bool> writeCurrentLocationRegionToAppGroup(
  SharedPreferencesAsync prefs, {
  required int? regionCode,
  required String? regionName,
}) async {
  if (regionCode == null || regionName == null) {
    return _removeAll(prefs, const [
      AppGroupKeys.currentLocationRegionCode,
      AppGroupKeys.currentLocationRegionName,
    ]);
  }
  final codeChanged = await _setString(
    prefs,
    AppGroupKeys.currentLocationRegionCode,
    regionCode.toString(),
  );
  final nameChanged = await _setString(
    prefs,
    AppGroupKeys.currentLocationRegionName,
    regionName,
  );
  return codeChanged || nameChanged;
}

Future<bool> _setString(
  SharedPreferencesAsync prefs,
  String key,
  String value,
) async {
  if (await prefs.getString(key) == value) {
    return false;
  }
  await prefs.setString(key, value);
  return true;
}

Future<bool> _setBool(
  SharedPreferencesAsync prefs,
  String key, {
  required bool value,
}) async {
  if (await prefs.getBool(key) == value) {
    return false;
  }
  await prefs.setBool(key, value);
  return true;
}

Future<bool> _removeAll(SharedPreferencesAsync prefs, List<String> keys) async {
  var changed = false;
  for (final key in keys) {
    if (await prefs.getString(key) != null ||
        await prefs.getBool(key) != null) {
      await prefs.remove(key);
      changed = true;
    }
  }
  return changed;
}
