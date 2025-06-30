// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'information_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(informationRepository)
const informationRepositoryProvider = InformationRepositoryProvider._();

final class InformationRepositoryProvider
    extends $FunctionalProvider<InformationRepository, InformationRepository>
    with $Provider<InformationRepository> {
  const InformationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'informationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$informationRepositoryHash();

  @$internal
  @override
  $ProviderElement<InformationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  InformationRepository create(Ref ref) {
    return informationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InformationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $ValueProvider<InformationRepository>(value),
    );
  }
}

String _$informationRepositoryHash() =>
    r'75d6f6f782d220137ee4574b68b6dbb676b98ec3';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
