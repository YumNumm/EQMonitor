// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_image_delay_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 強震モニタ画像の取得に使う公開遅延。

@ProviderFor(kyoshinMonitorImageDelay)
final kyoshinMonitorImageDelayProvider = KyoshinMonitorImageDelayProvider._();

/// 強震モニタ画像の取得に使う公開遅延。

final class KyoshinMonitorImageDelayProvider
    extends $FunctionalProvider<Duration?, Duration?, Duration?>
    with $Provider<Duration?> {
  /// 強震モニタ画像の取得に使う公開遅延。
  KyoshinMonitorImageDelayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorImageDelayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorImageDelayHash();

  @$internal
  @override
  $ProviderElement<Duration?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Duration? create(Ref ref) {
    return kyoshinMonitorImageDelay(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Duration? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Duration?>(value),
    );
  }
}

String _$kyoshinMonitorImageDelayHash() =>
    r'b7557df6b6e4037a453483ca88e5764e65912e26';
