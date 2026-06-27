// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_list_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eewListRepository)
final eewListRepositoryProvider = EewListRepositoryProvider._();

final class EewListRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<EewListRepository>,
          EewListRepository,
          FutureOr<EewListRepository>
        >
    with
        $FutureModifier<EewListRepository>,
        $FutureProvider<EewListRepository> {
  EewListRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eewListRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eewListRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<EewListRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EewListRepository> create(Ref ref) {
    return eewListRepository(ref);
  }
}

String _$eewListRepositoryHash() => r'87aa8a2c7296a774452b66a1b5c0a6306385f219';
