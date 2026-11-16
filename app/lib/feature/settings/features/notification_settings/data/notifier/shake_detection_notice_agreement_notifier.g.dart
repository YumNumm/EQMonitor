// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_notice_agreement_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ShakeDetectionNoticeAgreed)
final shakeDetectionNoticeAgreedProvider =
    ShakeDetectionNoticeAgreedProvider._();

final class ShakeDetectionNoticeAgreedProvider
    extends $AsyncNotifierProvider<ShakeDetectionNoticeAgreed, bool> {
  ShakeDetectionNoticeAgreedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionNoticeAgreedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionNoticeAgreedHash();

  @$internal
  @override
  ShakeDetectionNoticeAgreed create() => ShakeDetectionNoticeAgreed();
}

String _$shakeDetectionNoticeAgreedHash() =>
    r'0d7b2b212aa2de2589c8035c82f561a46366c076';

abstract class _$ShakeDetectionNoticeAgreed extends $AsyncNotifier<bool> {
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
