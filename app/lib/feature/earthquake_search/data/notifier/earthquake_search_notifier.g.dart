// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_search_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EarthquakeSearchNotifier)
final earthquakeSearchProvider = EarthquakeSearchNotifierFamily._();

final class EarthquakeSearchNotifierProvider
    extends
        $AsyncNotifierProvider<
          EarthquakeSearchNotifier,
          EarthquakeSearchNotifierState
        > {
  EarthquakeSearchNotifierProvider._({
    required EarthquakeSearchNotifierFamily super.from,
    required EarthquakeSearchParameter super.argument,
  }) : super(
         retry: null,
         name: r'earthquakeSearchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$earthquakeSearchNotifierHash();

  @override
  String toString() {
    return r'earthquakeSearchProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EarthquakeSearchNotifier create() => EarthquakeSearchNotifier();

  @override
  bool operator ==(Object other) {
    return other is EarthquakeSearchNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$earthquakeSearchNotifierHash() =>
    r'3c714a2bf4cf789761e6b0549c5bd022f39e9279';

final class EarthquakeSearchNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          EarthquakeSearchNotifier,
          AsyncValue<EarthquakeSearchNotifierState>,
          EarthquakeSearchNotifierState,
          FutureOr<EarthquakeSearchNotifierState>,
          EarthquakeSearchParameter
        > {
  EarthquakeSearchNotifierFamily._()
    : super(
        retry: null,
        name: r'earthquakeSearchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EarthquakeSearchNotifierProvider call(EarthquakeSearchParameter parameter) =>
      EarthquakeSearchNotifierProvider._(argument: parameter, from: this);

  @override
  String toString() => r'earthquakeSearchProvider';
}

abstract class _$EarthquakeSearchNotifier
    extends $AsyncNotifier<EarthquakeSearchNotifierState> {
  late final _$args = ref.$arg as EarthquakeSearchParameter;
  EarthquakeSearchParameter get parameter => _$args;

  FutureOr<EarthquakeSearchNotifierState> build(
    EarthquakeSearchParameter parameter,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<EarthquakeSearchNotifierState>,
              EarthquakeSearchNotifierState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<EarthquakeSearchNotifierState>,
                EarthquakeSearchNotifierState
              >,
              AsyncValue<EarthquakeSearchNotifierState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
