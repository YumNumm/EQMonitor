// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'app_group_preferences.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// iOS App Groups UserDefaults (suite: group.net.yumnumm.eqmonitor).
/// Widget Extension が同じ suite から設定値を読む。

@ProviderFor(appGroupPreferences)
final appGroupPreferencesProvider = AppGroupPreferencesProvider._();

/// iOS App Groups UserDefaults (suite: group.net.yumnumm.eqmonitor).
/// Widget Extension が同じ suite から設定値を読む。

final class AppGroupPreferencesProvider
    extends
        $FunctionalProvider<
          AsyncValue<SharedPreferencesAsync>,
          SharedPreferencesAsync,
          FutureOr<SharedPreferencesAsync>
        >
    with
        $FutureModifier<SharedPreferencesAsync>,
        $FutureProvider<SharedPreferencesAsync> {
  /// iOS App Groups UserDefaults (suite: group.net.yumnumm.eqmonitor).
  /// Widget Extension が同じ suite から設定値を読む。
  AppGroupPreferencesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appGroupPreferencesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appGroupPreferencesHash();

  @$internal
  @override
  $FutureProviderElement<SharedPreferencesAsync> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SharedPreferencesAsync> create(Ref ref) {
    return appGroupPreferences(ref);
  }
}

String _$appGroupPreferencesHash() =>
    r'e195df95c5cd9523177fdfbeb453f58be7af658f';
