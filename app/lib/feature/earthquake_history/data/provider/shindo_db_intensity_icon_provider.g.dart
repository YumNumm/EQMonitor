// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shindo_db_intensity_icon_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 震度データベース固有の震度階級 (旧階級 5/6・歴史的階級) の地図用アイコン
///
/// 現行の JMA 震度と一致する階級は intensityIconProvider の画像を流用するため、
/// ここでは [ShindoDbIntensityClass.exactJmaIntensity] を持たない階級のみ描画する。

@ProviderFor(shindoDbIntensityIcon)
final shindoDbIntensityIconProvider = ShindoDbIntensityIconProvider._();

/// 震度データベース固有の震度階級 (旧階級 5/6・歴史的階級) の地図用アイコン
///
/// 現行の JMA 震度と一致する階級は intensityIconProvider の画像を流用するため、
/// ここでは [ShindoDbIntensityClass.exactJmaIntensity] を持たない階級のみ描画する。

final class ShindoDbIntensityIconProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<ShindoDbIntensityClass, Uint8List>>,
          Map<ShindoDbIntensityClass, Uint8List>,
          FutureOr<Map<ShindoDbIntensityClass, Uint8List>>
        >
    with
        $FutureModifier<Map<ShindoDbIntensityClass, Uint8List>>,
        $FutureProvider<Map<ShindoDbIntensityClass, Uint8List>> {
  /// 震度データベース固有の震度階級 (旧階級 5/6・歴史的階級) の地図用アイコン
  ///
  /// 現行の JMA 震度と一致する階級は intensityIconProvider の画像を流用するため、
  /// ここでは [ShindoDbIntensityClass.exactJmaIntensity] を持たない階級のみ描画する。
  ShindoDbIntensityIconProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shindoDbIntensityIconProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shindoDbIntensityIconHash();

  @$internal
  @override
  $FutureProviderElement<Map<ShindoDbIntensityClass, Uint8List>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<ShindoDbIntensityClass, Uint8List>> create(Ref ref) {
    return shindoDbIntensityIcon(ref);
  }
}

String _$shindoDbIntensityIconHash() =>
    r'ca91bef790b29e935f1ffb3015b1f02705f9ad32';
