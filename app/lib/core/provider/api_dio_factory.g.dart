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

String _$apiDioFactoryHash() => r'4a81f8c8bd466ad39e6183d2e0239f92504aa972';
