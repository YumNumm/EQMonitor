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
    extends $AsyncNotifierProvider<EstimatedIntensityNoticeShown, bool> {
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
}

String _$estimatedIntensityNoticeShownHash() =>
    r'bc480fc80bbfe3ef3a3670e9e7223e00c2b69563';

abstract class _$EstimatedIntensityNoticeShown extends $AsyncNotifier<bool> {
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
