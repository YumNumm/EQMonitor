// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'hinet_seismicity_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(hinetSeismicityRepository)
final hinetSeismicityRepositoryProvider = HinetSeismicityRepositoryProvider._();

final class HinetSeismicityRepositoryProvider
    extends
        $FunctionalProvider<
          HinetSeismicityRepository,
          HinetSeismicityRepository,
          HinetSeismicityRepository
        >
    with $Provider<HinetSeismicityRepository> {
  HinetSeismicityRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hinetSeismicityRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hinetSeismicityRepositoryHash();

  @$internal
  @override
  $ProviderElement<HinetSeismicityRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HinetSeismicityRepository create(Ref ref) {
    return hinetSeismicityRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HinetSeismicityRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HinetSeismicityRepository>(value),
    );
  }
}

String _$hinetSeismicityRepositoryHash() =>
    r'62aa634454b08088a61b5300e68951acdcc7774d';
