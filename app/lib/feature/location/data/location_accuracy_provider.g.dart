// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'location_accuracy_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 位置情報権限の精度。
///
/// iOS の「正確な位置情報」オフ / Android の「おおよその位置」許可で
/// [LocationAccuracyStatus.reduced] になる。取得できない場合も精度を保証
/// できないため [LocationAccuracyStatus.reduced] として扱う。
///
/// 設定アプリで変更されうるため、アプリ復帰時に再取得する。

@ProviderFor(locationAccuracyStatus)
final locationAccuracyStatusProvider = LocationAccuracyStatusProvider._();

/// 位置情報権限の精度。
///
/// iOS の「正確な位置情報」オフ / Android の「おおよその位置」許可で
/// [LocationAccuracyStatus.reduced] になる。取得できない場合も精度を保証
/// できないため [LocationAccuracyStatus.reduced] として扱う。
///
/// 設定アプリで変更されうるため、アプリ復帰時に再取得する。

final class LocationAccuracyStatusProvider
    extends
        $FunctionalProvider<
          AsyncValue<LocationAccuracyStatus>,
          LocationAccuracyStatus,
          FutureOr<LocationAccuracyStatus>
        >
    with
        $FutureModifier<LocationAccuracyStatus>,
        $FutureProvider<LocationAccuracyStatus> {
  /// 位置情報権限の精度。
  ///
  /// iOS の「正確な位置情報」オフ / Android の「おおよその位置」許可で
  /// [LocationAccuracyStatus.reduced] になる。取得できない場合も精度を保証
  /// できないため [LocationAccuracyStatus.reduced] として扱う。
  ///
  /// 設定アプリで変更されうるため、アプリ復帰時に再取得する。
  LocationAccuracyStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationAccuracyStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationAccuracyStatusHash();

  @$internal
  @override
  $FutureProviderElement<LocationAccuracyStatus> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LocationAccuracyStatus> create(Ref ref) {
    return locationAccuracyStatus(ref);
  }
}

String _$locationAccuracyStatusHash() =>
    r'cd025c110ad0eda982b708643433c441131c2e8d';
