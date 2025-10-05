// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'information_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(informationRepository)
const informationRepositoryProvider = InformationRepositoryProvider._();

final class InformationRepositoryProvider
    extends
        $FunctionalProvider<
          InformationRepository,
          InformationRepository,
          InformationRepository
        >
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
      providerOverride: $SyncValueProvider<InformationRepository>(value),
    );
  }
}

String _$informationRepositoryHash() =>
    r'75d6f6f782d220137ee4574b68b6dbb676b98ec3';
