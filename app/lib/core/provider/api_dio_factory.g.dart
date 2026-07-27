// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'api_dio_factory.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(apiDioFactory)
final apiDioFactoryProvider = ApiDioFactoryProvider._();

final class ApiDioFactoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<ApiDioFactory>,
          ApiDioFactory,
          FutureOr<ApiDioFactory>
        >
    with $FutureModifier<ApiDioFactory>, $FutureProvider<ApiDioFactory> {
  ApiDioFactoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiDioFactoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiDioFactoryHash();

  @$internal
  @override
  $FutureProviderElement<ApiDioFactory> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ApiDioFactory> create(Ref ref) {
    return apiDioFactory(ref);
  }
}

String _$apiDioFactoryHash() => r'46e9a4c1cb7118f78de54867864e84783d1288c5';
