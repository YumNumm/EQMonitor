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
    extends $AsyncNotifierProvider<BetaTestingAgreed, bool> {
  BetaTestingAgreedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'betaTestingAgreedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$betaTestingAgreedHash();

  @$internal
  @override
  BetaTestingAgreed create() => BetaTestingAgreed();
}

String _$betaTestingAgreedHash() => r'239eac780d912fc4a20b8fec8a002a9ab84dd7f0';

abstract class _$BetaTestingAgreed extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
