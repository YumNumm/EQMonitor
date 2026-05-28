// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'revenue_cat_initialization_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(revenueCatInitialization)
final revenueCatInitializationProvider = RevenueCatInitializationProvider._();

final class RevenueCatInitializationProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  RevenueCatInitializationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'revenueCatInitializationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$revenueCatInitializationHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return revenueCatInitialization(ref);
  }
}

String _$revenueCatInitializationHash() =>
    r'7d9989e3e47f70c6c2f63ecb7f8b91ecb88b523e';
