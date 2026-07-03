// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_history_map_layer_parameter_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EarthquakeHistoryMapLayerParameterNotifier)
final earthquakeHistoryMapLayerParameterProvider =
    EarthquakeHistoryMapLayerParameterNotifierProvider._();

final class EarthquakeHistoryMapLayerParameterNotifierProvider
    extends
        $AsyncNotifierProvider<
          EarthquakeHistoryMapLayerParameterNotifier,
          EarthquakeHistoryMapLayerParameter
        > {
  EarthquakeHistoryMapLayerParameterNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'earthquakeHistoryMapLayerParameterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$earthquakeHistoryMapLayerParameterNotifierHash();

  @$internal
  @override
  EarthquakeHistoryMapLayerParameterNotifier create() =>
      EarthquakeHistoryMapLayerParameterNotifier();
}

String _$earthquakeHistoryMapLayerParameterNotifierHash() =>
    r'8b701b4f09faea950751a9a7bd92becfdb7397c8';

abstract class _$EarthquakeHistoryMapLayerParameterNotifier
    extends $AsyncNotifier<EarthquakeHistoryMapLayerParameter> {
  FutureOr<EarthquakeHistoryMapLayerParameter> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<EarthquakeHistoryMapLayerParameter>,
              EarthquakeHistoryMapLayerParameter
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<EarthquakeHistoryMapLayerParameter>,
                EarthquakeHistoryMapLayerParameter
              >,
              AsyncValue<EarthquakeHistoryMapLayerParameter>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
