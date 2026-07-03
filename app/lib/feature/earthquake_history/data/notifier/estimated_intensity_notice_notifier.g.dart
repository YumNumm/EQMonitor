// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'estimated_intensity_notice_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EstimatedIntensityNoticeShown)
final estimatedIntensityNoticeShownProvider =
    EstimatedIntensityNoticeShownProvider._();

final class EstimatedIntensityNoticeShownProvider
    extends $NotifierProvider<EstimatedIntensityNoticeShown, bool> {
  EstimatedIntensityNoticeShownProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'estimatedIntensityNoticeShownProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$estimatedIntensityNoticeShownHash();

  @$internal
  @override
  EstimatedIntensityNoticeShown create() => EstimatedIntensityNoticeShown();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$estimatedIntensityNoticeShownHash() =>
    r'90dafe2a98fc50f35ad8f26ecd9df3eab121ea6f';

abstract class _$EstimatedIntensityNoticeShown extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
