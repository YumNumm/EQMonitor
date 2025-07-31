// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'fcm_token_change_detector.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(FcmTokenChangeDetector)
const fcmTokenChangeDetectorProvider = FcmTokenChangeDetectorProvider._();

final class FcmTokenChangeDetectorProvider
    extends $AsyncNotifierProvider<FcmTokenChangeDetector, bool> {
  const FcmTokenChangeDetectorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fcmTokenChangeDetectorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fcmTokenChangeDetectorHash();

  @$internal
  @override
  FcmTokenChangeDetector create() => FcmTokenChangeDetector();
}

String _$fcmTokenChangeDetectorHash() =>
    r'bad2e1ff458e3076d8adb41f365864a69f694e46';

abstract class _$FcmTokenChangeDetector extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
