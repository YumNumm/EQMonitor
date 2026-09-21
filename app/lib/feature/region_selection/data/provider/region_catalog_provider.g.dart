// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'region_catalog_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(regionCatalog)
final regionCatalogProvider = RegionCatalogFamily._();

final class RegionCatalogProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<RegionOption>>,
          List<RegionOption>,
          FutureOr<List<RegionOption>>
        >
    with
        $FutureModifier<List<RegionOption>>,
        $FutureProvider<List<RegionOption>> {
  RegionCatalogProvider._({
    required RegionCatalogFamily super.from,
    required bool super.argument,
  }) : super(
         retry: null,
         name: r'regionCatalogProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$regionCatalogHash();

  @override
  String toString() {
    return r'regionCatalogProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<RegionOption>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<RegionOption>> create(Ref ref) {
    final argument = this.argument as bool;
    return regionCatalog(ref, notification: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RegionCatalogProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$regionCatalogHash() => r'0a2543f709e13b6103c8ba6ba78bacdcff667930';

final class RegionCatalogFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<RegionOption>>, bool> {
  RegionCatalogFamily._()
    : super(
        retry: null,
        name: r'regionCatalogProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RegionCatalogProvider call({bool notification = false}) =>
      RegionCatalogProvider._(argument: notification, from: this);

  @override
  String toString() => r'regionCatalogProvider';
}
