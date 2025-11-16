// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_alive_telegram.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// イベント終了していないEEWのうち、精度が低いものを除外したもの

@ProviderFor(eewAliveNormalTelegram)
const eewAliveNormalTelegramProvider = EewAliveNormalTelegramProvider._();

/// イベント終了していないEEWのうち、精度が低いものを除外したもの

final class EewAliveNormalTelegramProvider
    extends $FunctionalProvider<List<EewV1>, List<EewV1>, List<EewV1>>
    with $Provider<List<EewV1>> {
  /// イベント終了していないEEWのうち、精度が低いものを除外したもの
  const EewAliveNormalTelegramProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eewAliveNormalTelegramProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eewAliveNormalTelegramHash();

  @$internal
  @override
  $ProviderElement<List<EewV1>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<EewV1> create(Ref ref) {
    return eewAliveNormalTelegram(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<EewV1> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<EewV1>>(value),
    );
  }
}

String _$eewAliveNormalTelegramHash() =>
    r'7f675965e740729ae41accb3b058d7fe4f216dff';

/// イベント終了していないEEW

@ProviderFor(EewAliveTelegram)
const eewAliveTelegramProvider = EewAliveTelegramProvider._();

/// イベント終了していないEEW
final class EewAliveTelegramProvider
    extends $NotifierProvider<EewAliveTelegram, List<EewV1>?> {
  /// イベント終了していないEEW
  const EewAliveTelegramProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eewAliveTelegramProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eewAliveTelegramHash();

  @$internal
  @override
  EewAliveTelegram create() => EewAliveTelegram();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<EewV1>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<EewV1>?>(value),
    );
  }
}

String _$eewAliveTelegramHash() => r'bb7d83c2f9defdcef446234e4b2799effc9326ac';

/// イベント終了していないEEW

abstract class _$EewAliveTelegram extends $Notifier<List<EewV1>?> {
  List<EewV1>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<EewV1>?, List<EewV1>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<EewV1>?, List<EewV1>?>,
              List<EewV1>?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(eewAliveChecker)
const eewAliveCheckerProvider = EewAliveCheckerProvider._();

final class EewAliveCheckerProvider
    extends
        $FunctionalProvider<EewAliveChecker, EewAliveChecker, EewAliveChecker>
    with $Provider<EewAliveChecker> {
  const EewAliveCheckerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eewAliveCheckerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eewAliveCheckerHash();

  @$internal
  @override
  $ProviderElement<EewAliveChecker> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EewAliveChecker create(Ref ref) {
    return eewAliveChecker(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EewAliveChecker value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EewAliveChecker>(value),
    );
  }
}

String _$eewAliveCheckerHash() => r'f092d121ff9d9ea2b58fb253608779403a4ce39f';
