// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_history_early_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EarthquakeHistoryEarlyNotifier)
const earthquakeHistoryEarlyProvider = EarthquakeHistoryEarlyNotifierFamily._();

final class EarthquakeHistoryEarlyNotifierProvider
    extends
        $AsyncNotifierProvider<
          EarthquakeHistoryEarlyNotifier,
          EarthquakeHistoryEarlyNotifierState
        > {
  const EarthquakeHistoryEarlyNotifierProvider._({
    required EarthquakeHistoryEarlyNotifierFamily super.from,
    required EarthquakeHistoryEarlyParameter super.argument,
  }) : super(
         retry: null,
         name: r'earthquakeHistoryEarlyProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$earthquakeHistoryEarlyNotifierHash();

  @override
  String toString() {
    return r'earthquakeHistoryEarlyProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EarthquakeHistoryEarlyNotifier create() => EarthquakeHistoryEarlyNotifier();

  @override
  bool operator ==(Object other) {
    return other is EarthquakeHistoryEarlyNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$earthquakeHistoryEarlyNotifierHash() =>
    r'31b4e4df9d2a775c3aec6dc200abb1add915f2a5';

final class EarthquakeHistoryEarlyNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          EarthquakeHistoryEarlyNotifier,
          AsyncValue<EarthquakeHistoryEarlyNotifierState>,
          EarthquakeHistoryEarlyNotifierState,
          FutureOr<EarthquakeHistoryEarlyNotifierState>,
          EarthquakeHistoryEarlyParameter
        > {
  const EarthquakeHistoryEarlyNotifierFamily._()
    : super(
        retry: null,
        name: r'earthquakeHistoryEarlyProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EarthquakeHistoryEarlyNotifierProvider call(
    EarthquakeHistoryEarlyParameter parameter,
  ) =>
      EarthquakeHistoryEarlyNotifierProvider._(argument: parameter, from: this);

  @override
  String toString() => r'earthquakeHistoryEarlyProvider';
}

abstract class _$EarthquakeHistoryEarlyNotifier
    extends $AsyncNotifier<EarthquakeHistoryEarlyNotifierState> {
  late final _$args = ref.$arg as EarthquakeHistoryEarlyParameter;
  EarthquakeHistoryEarlyParameter get parameter => _$args;

  FutureOr<EarthquakeHistoryEarlyNotifierState> build(
    EarthquakeHistoryEarlyParameter parameter,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<
              AsyncValue<EarthquakeHistoryEarlyNotifierState>,
              EarthquakeHistoryEarlyNotifierState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<EarthquakeHistoryEarlyNotifierState>,
                EarthquakeHistoryEarlyNotifierState
              >,
              AsyncValue<EarthquakeHistoryEarlyNotifierState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
