// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'parameter_local_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(parameterLocalDataSource)
final parameterLocalDataSourceProvider = ParameterLocalDataSourceProvider._();

final class ParameterLocalDataSourceProvider
    extends
        $FunctionalProvider<
          AsyncValue<ParameterLocalDataSource>,
          ParameterLocalDataSource,
          FutureOr<ParameterLocalDataSource>
        >
    with
        $FutureModifier<ParameterLocalDataSource>,
        $FutureProvider<ParameterLocalDataSource> {
  ParameterLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'parameterLocalDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$parameterLocalDataSourceHash();

  @$internal
  @override
  $FutureProviderElement<ParameterLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ParameterLocalDataSource> create(Ref ref) {
    return parameterLocalDataSource(ref);
  }
}

String _$parameterLocalDataSourceHash() =>
    r'a00547419e127e68474fb2ecba070e5f687e81f2';
