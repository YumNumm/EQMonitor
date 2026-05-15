// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'start_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(startRepository)
final startRepositoryProvider = StartRepositoryProvider._();

final class StartRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<StartRepository>,
          StartRepository,
          FutureOr<StartRepository>
        >
    with $FutureModifier<StartRepository>, $FutureProvider<StartRepository> {
  StartRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'startRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$startRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<StartRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<StartRepository> create(Ref ref) {
    return startRepository(ref);
  }
}

String _$startRepositoryHash() => r'63b74d41e2a06fe9e535d06c22793a720c0dfa88';
