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
final eewAliveNormalTelegramProvider = EewAliveNormalTelegramProvider._();

/// イベント終了していないEEWのうち、精度が低いものを除外したもの

final class EewAliveNormalTelegramProvider
    extends
        $FunctionalProvider<
          List<EewItemWithRelations>,
          List<EewItemWithRelations>,
          List<EewItemWithRelations>
        >
    with $Provider<List<EewItemWithRelations>> {
  /// イベント終了していないEEWのうち、精度が低いものを除外したもの
  EewAliveNormalTelegramProvider._()
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
  $ProviderElement<List<EewItemWithRelations>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<EewItemWithRelations> create(Ref ref) {
    return eewAliveNormalTelegram(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<EewItemWithRelations> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<EewItemWithRelations>>(value),
    );
  }
}

String _$eewAliveNormalTelegramHash() =>
    r'8088c01141cdf06b31457ba474b3f2fff934b0d4';

/// イベント終了していないEEW

@ProviderFor(EewAliveTelegram)
final eewAliveTelegramProvider = EewAliveTelegramProvider._();

/// イベント終了していないEEW
final class EewAliveTelegramProvider
    extends $NotifierProvider<EewAliveTelegram, List<EewItemWithRelations>?> {
  /// イベント終了していないEEW
  EewAliveTelegramProvider._()
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
  Override overrideWithValue(List<EewItemWithRelations>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<EewItemWithRelations>?>(value),
    );
  }
}

String _$eewAliveTelegramHash() => r'23e35a32dec961208418370a17096629db1b5544';

/// イベント終了していないEEW

abstract class _$EewAliveTelegram
    extends $Notifier<List<EewItemWithRelations>?> {
  List<EewItemWithRelations>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<List<EewItemWithRelations>?, List<EewItemWithRelations>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                List<EewItemWithRelations>?,
                List<EewItemWithRelations>?
              >,
              List<EewItemWithRelations>?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(eewAliveChecker)
final eewAliveCheckerProvider = EewAliveCheckerProvider._();

final class EewAliveCheckerProvider
    extends
        $FunctionalProvider<EewAliveChecker, EewAliveChecker, EewAliveChecker>
    with $Provider<EewAliveChecker> {
  EewAliveCheckerProvider._()
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
