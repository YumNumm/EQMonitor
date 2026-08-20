// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_offset_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 強震モニタ画像の遅延を保持する

@ProviderFor(kyoshinMonitorEffectiveOffset)
final kyoshinMonitorEffectiveOffsetProvider =
    KyoshinMonitorEffectiveOffsetProvider._();

/// 強震モニタ画像の遅延を保持する

final class KyoshinMonitorEffectiveOffsetProvider
    extends $FunctionalProvider<Duration?, Duration?, Duration?>
    with $Provider<Duration?> {
  /// 強震モニタ画像の遅延を保持する
  KyoshinMonitorEffectiveOffsetProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorEffectiveOffsetProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorEffectiveOffsetHash();

  @$internal
  @override
  $ProviderElement<Duration?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Duration? create(Ref ref) {
    return kyoshinMonitorEffectiveOffset(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Duration? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Duration?>(value),
    );
  }
}

String _$kyoshinMonitorEffectiveOffsetHash() =>
    r'801b005fce0c5f750f9cdb4dffa13e02fcfaf26a';
