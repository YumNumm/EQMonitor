// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'home_earthquake_history_parameter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// ホーム地震履歴カード用の検索パラメータ。
/// 現在地・指定地域が未設定のときは `null`。

@ProviderFor(homeEarthquakeHistoryParameter)
final homeEarthquakeHistoryParameterProvider =
    HomeEarthquakeHistoryParameterProvider._();

/// ホーム地震履歴カード用の検索パラメータ。
/// 現在地・指定地域が未設定のときは `null`。

final class HomeEarthquakeHistoryParameterProvider
    extends
        $FunctionalProvider<
          AsyncValue<EarthquakeHistoryParameter?>,
          EarthquakeHistoryParameter?,
          FutureOr<EarthquakeHistoryParameter?>
        >
    with
        $FutureModifier<EarthquakeHistoryParameter?>,
        $FutureProvider<EarthquakeHistoryParameter?> {
  /// ホーム地震履歴カード用の検索パラメータ。
  /// 現在地・指定地域が未設定のときは `null`。
  HomeEarthquakeHistoryParameterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeEarthquakeHistoryParameterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeEarthquakeHistoryParameterHash();

  @$internal
  @override
  $FutureProviderElement<EarthquakeHistoryParameter?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EarthquakeHistoryParameter?> create(Ref ref) {
    return homeEarthquakeHistoryParameter(ref);
  }
}

String _$homeEarthquakeHistoryParameterHash() =>
    r'49fa0f7b04983ef860e75cdd5391e938b4726872';
