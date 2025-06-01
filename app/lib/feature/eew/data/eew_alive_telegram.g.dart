// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'eew_alive_telegram.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// イベント終了していないEEWのうち、精度が低いものを除外したもの
@ProviderFor(eewAliveNormalTelegram)
const eewAliveNormalTelegramProvider = EewAliveNormalTelegramProvider._();

/// イベント終了していないEEWのうち、精度が低いものを除外したもの
final class EewAliveNormalTelegramProvider
    extends $FunctionalProvider<List<EewV1>, List<EewV1>>
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
      providerOverride: $ValueProvider<List<EewV1>>(value),
    );
  }
}

String _$eewAliveNormalTelegramHash() =>
    r'3d5ba64b3f98437062584f49208f9898a32358f3';

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

  @$internal
  @override
  $NotifierProviderElement<EewAliveTelegram, List<EewV1>?> $createElement(
    $ProviderPointer pointer,
  ) => $NotifierProviderElement(pointer);

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<EewV1>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<List<EewV1>?>(value),
    );
  }
}

String _$eewAliveTelegramHash() => r'bb7d83c2f9defdcef446234e4b2799effc9326ac';

abstract class _$EewAliveTelegram extends $Notifier<List<EewV1>?> {
  List<EewV1>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<EewV1>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<EewV1>?>,
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
    extends $FunctionalProvider<EewAliveChecker, EewAliveChecker>
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
      providerOverride: $ValueProvider<EewAliveChecker>(value),
    );
  }
}

String _$eewAliveCheckerHash() => r'f092d121ff9d9ea2b58fb253608779403a4ce39f';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
