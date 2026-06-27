// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'changelog_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(changelogRepository)
final changelogRepositoryProvider = ChangelogRepositoryProvider._();

final class ChangelogRepositoryProvider
    extends
        $FunctionalProvider<
          ChangelogRepository,
          ChangelogRepository,
          ChangelogRepository
        >
    with $Provider<ChangelogRepository> {
  ChangelogRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'changelogRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$changelogRepositoryHash();

  @$internal
  @override
  $ProviderElement<ChangelogRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ChangelogRepository create(Ref ref) {
    return changelogRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChangelogRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChangelogRepository>(value),
    );
  }
}

String _$changelogRepositoryHash() =>
    r'd17fb376d8c89acfa2a2970bd3d578fc3c19ccdc';
