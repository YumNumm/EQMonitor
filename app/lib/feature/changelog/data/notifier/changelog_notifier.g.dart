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
    extends
        $NotifierProvider<
          ChangelogNotifier,
          AsyncValue<api.ChangelogResponse?>
        > {
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<api.ChangelogResponse?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<api.ChangelogResponse?>>(
        value,
      ),
    );
  }
}

String _$changelogNotifierHash() => r'2b1d2de7ddca621221542b36ee4eec4b29e89e27';

abstract class _$ChangelogNotifier
    extends $Notifier<AsyncValue<api.ChangelogResponse?>> {
  AsyncValue<api.ChangelogResponse?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<api.ChangelogResponse?>,
              AsyncValue<api.ChangelogResponse?>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<api.ChangelogResponse?>,
                AsyncValue<api.ChangelogResponse?>
              >,
              AsyncValue<api.ChangelogResponse?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
