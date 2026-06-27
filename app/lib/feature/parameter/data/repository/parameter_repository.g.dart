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
    r'd637cb6055bb44d2f0a5c58dac6dca8151a3b47d';
