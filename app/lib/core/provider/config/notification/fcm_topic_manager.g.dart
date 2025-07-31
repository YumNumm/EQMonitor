// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'fcm_topic_manager.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(FcmTopicManager)
const fcmTopicManagerProvider = FcmTopicManagerProvider._();

final class FcmTopicManagerProvider
    extends $NotifierProvider<FcmTopicManager, List<String>> {
  const FcmTopicManagerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fcmTopicManagerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fcmTopicManagerHash();

  @$internal
  @override
  FcmTopicManager create() => FcmTopicManager();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$fcmTopicManagerHash() => r'c03c4e5292fb1f4188af1868cf84da16947330e7';

abstract class _$FcmTopicManager extends $Notifier<List<String>> {
  List<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<String>, List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<String>, List<String>>,
              List<String>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
