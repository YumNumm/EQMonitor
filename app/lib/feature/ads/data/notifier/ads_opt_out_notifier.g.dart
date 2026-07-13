// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ads_opt_out_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdsOptOutNotifier)
final adsOptOutProvider = AdsOptOutNotifierProvider._();

final class AdsOptOutNotifierProvider
    extends $AsyncNotifierProvider<AdsOptOutNotifier, bool> {
  AdsOptOutNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adsOptOutProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adsOptOutNotifierHash();

  @$internal
  @override
  AdsOptOutNotifier create() => AdsOptOutNotifier();
}

String _$adsOptOutNotifierHash() => r'0a02c7290f73d1cffcfcf625fe5aa0d435d3295c';

abstract class _$AdsOptOutNotifier extends $AsyncNotifier<bool> {
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
