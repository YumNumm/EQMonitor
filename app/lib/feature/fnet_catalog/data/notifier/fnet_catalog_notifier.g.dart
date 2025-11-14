// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'fnet_catalog_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FnetCatalogNotifier)
const fnetCatalogProvider = FnetCatalogNotifierFamily._();

final class FnetCatalogNotifierProvider
    extends
        $AsyncNotifierProvider<FnetCatalogNotifier, List<FnetEarthquakeEvent>> {
  const FnetCatalogNotifierProvider._({
    required FnetCatalogNotifierFamily super.from,
    required ({int year, int? month}) super.argument,
  }) : super(
         retry: null,
         name: r'fnetCatalogProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fnetCatalogNotifierHash();

  @override
  String toString() {
    return r'fnetCatalogProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  FnetCatalogNotifier create() => FnetCatalogNotifier();

  @override
  bool operator ==(Object other) {
    return other is FnetCatalogNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fnetCatalogNotifierHash() =>
    r'978c5e1dc7ca01ebd6a6bf3d4674eb3aeba2ddbd';

final class FnetCatalogNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          FnetCatalogNotifier,
          AsyncValue<List<FnetEarthquakeEvent>>,
          List<FnetEarthquakeEvent>,
          FutureOr<List<FnetEarthquakeEvent>>,
          ({int year, int? month})
        > {
  const FnetCatalogNotifierFamily._()
    : super(
        retry: null,
        name: r'fnetCatalogProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FnetCatalogNotifierProvider call({required int year, int? month}) =>
      FnetCatalogNotifierProvider._(
        argument: (year: year, month: month),
        from: this,
      );

  @override
  String toString() => r'fnetCatalogProvider';
}

abstract class _$FnetCatalogNotifier
    extends $AsyncNotifier<List<FnetEarthquakeEvent>> {
  late final _$args = ref.$arg as ({int year, int? month});
  int get year => _$args.year;
  int? get month => _$args.month;

  FutureOr<List<FnetEarthquakeEvent>> build({required int year, int? month});
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(year: _$args.year, month: _$args.month);
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<FnetEarthquakeEvent>>,
              List<FnetEarthquakeEvent>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<FnetEarthquakeEvent>>,
                List<FnetEarthquakeEvent>
              >,
              AsyncValue<List<FnetEarthquakeEvent>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
