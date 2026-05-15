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
    extends $NotifierProvider<AdsOptOutNotifier, bool> {
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$adsOptOutNotifierHash() => r'878e447190e717cc4a5c20a0e7de5d10817ef474';

abstract class _$AdsOptOutNotifier extends $Notifier<bool> {
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
