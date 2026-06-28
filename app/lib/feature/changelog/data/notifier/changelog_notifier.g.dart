// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'changelog_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChangelogNotifier)
final changelogProvider = ChangelogNotifierProvider._();

final class ChangelogNotifierProvider
    extends $AsyncNotifierProvider<ChangelogNotifier, api.ChangelogResponse> {
  ChangelogNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'changelogProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$changelogNotifierHash();

  @$internal
  @override
  ChangelogNotifier create() => ChangelogNotifier();
}

String _$changelogNotifierHash() => r'10b2985ddc08ec439dcd8a74e92e40db472dcbcf';

abstract class _$ChangelogNotifier
    extends $AsyncNotifier<api.ChangelogResponse> {
  FutureOr<api.ChangelogResponse> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<api.ChangelogResponse>, api.ChangelogResponse>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<api.ChangelogResponse>,
                api.ChangelogResponse
              >,
              AsyncValue<api.ChangelogResponse>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
