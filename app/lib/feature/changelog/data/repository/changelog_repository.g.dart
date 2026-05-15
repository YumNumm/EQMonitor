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
          AsyncValue<ChangelogRepository>,
          ChangelogRepository,
          FutureOr<ChangelogRepository>
        >
    with
        $FutureModifier<ChangelogRepository>,
        $FutureProvider<ChangelogRepository> {
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
  $FutureProviderElement<ChangelogRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ChangelogRepository> create(Ref ref) {
    return changelogRepository(ref);
  }
}

String _$changelogRepositoryHash() =>
    r'edcb1620cd2b9eab138cf94a32ac8d2ca3e3bae4';
