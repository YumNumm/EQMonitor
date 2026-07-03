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
          List<EewTelegramItem>,
          List<EewTelegramItem>,
          List<EewTelegramItem>
        >
    with $Provider<List<EewTelegramItem>> {
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
  $ProviderElement<List<EewTelegramItem>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<EewTelegramItem> create(Ref ref) {
    return eewAliveNormalTelegram(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<EewTelegramItem> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<EewTelegramItem>>(value),
    );
  }
}

String _$eewAliveNormalTelegramHash() =>
    r'b280741e0759e3264220bfd63996a0aa51bc61ba';

/// イベント終了していないEEW

@ProviderFor(EewAliveTelegram)
final eewAliveTelegramProvider = EewAliveTelegramProvider._();

/// イベント終了していないEEW
final class EewAliveTelegramProvider
    extends $NotifierProvider<EewAliveTelegram, List<EewTelegramItem>?> {
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
  Override overrideWithValue(List<EewTelegramItem>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<EewTelegramItem>?>(value),
    );
  }
}

String _$eewAliveTelegramHash() => r'23b0e0d991a98b0891af5fdb9a22ffcf71d6d2b5';

/// イベント終了していないEEW

abstract class _$EewAliveTelegram extends $Notifier<List<EewTelegramItem>?> {
  List<EewTelegramItem>? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<List<EewTelegramItem>?, List<EewTelegramItem>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<EewTelegramItem>?, List<EewTelegramItem>?>,
              List<EewTelegramItem>?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
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
