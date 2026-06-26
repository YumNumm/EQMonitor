// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'beta_testing_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BetaTestingAgreed)
final betaTestingAgreedProvider = BetaTestingAgreedProvider._();

final class BetaTestingAgreedProvider
    extends $NotifierProvider<BetaTestingAgreed, bool> {
  BetaTestingAgreedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'betaTestingAgreedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$betaTestingAgreedHash();

  @$internal
  @override
  BetaTestingAgreed create() => BetaTestingAgreed();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$betaTestingAgreedHash() => r'4b19f15edbf808bead1fb43e236490580c0db3d8';

abstract class _$BetaTestingAgreed extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
