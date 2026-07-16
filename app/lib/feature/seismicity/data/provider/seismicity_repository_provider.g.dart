// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'seismicity_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(seismicityRepository)
final seismicityRepositoryProvider = SeismicityRepositoryProvider._();

final class SeismicityRepositoryProvider
    extends
        $FunctionalProvider<
          riverpod.AsyncValue<SeismicityRepository>,
          SeismicityRepository,
          FutureOr<SeismicityRepository>
        >
    with
        $FutureModifier<SeismicityRepository>,
        $FutureProvider<SeismicityRepository> {
  SeismicityRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'seismicityRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$seismicityRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<SeismicityRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SeismicityRepository> create(Ref ref) {
    return seismicityRepository(ref);
  }
}

String _$seismicityRepositoryHash() =>
    r'ef8c92b707fd167688724154a109bf1f29211a3a';
