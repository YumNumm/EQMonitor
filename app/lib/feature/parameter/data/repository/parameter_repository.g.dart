// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'parameter_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(parameterRepository)
final parameterRepositoryProvider = ParameterRepositoryProvider._();

final class ParameterRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<ParameterRepository>,
          ParameterRepository,
          FutureOr<ParameterRepository>
        >
    with
        $FutureModifier<ParameterRepository>,
        $FutureProvider<ParameterRepository> {
  ParameterRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'parameterRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$parameterRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<ParameterRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ParameterRepository> create(Ref ref) {
    return parameterRepository(ref);
  }
}

String _$parameterRepositoryHash() =>
    r'00aebd4b70a83402457e3cdcb32197e45026cbb9';
