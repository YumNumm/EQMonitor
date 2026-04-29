// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_history_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EarthquakeHistoryNotifier)
final earthquakeHistoryProvider = EarthquakeHistoryNotifierFamily._();

final class EarthquakeHistoryNotifierProvider
    extends
        $AsyncNotifierProvider<
          EarthquakeHistoryNotifier,
          EarthquakeHistoryNotifierState
        > {
  EarthquakeHistoryNotifierProvider._({
    required EarthquakeHistoryNotifierFamily super.from,
    required EarthquakeHistoryParameter super.argument,
  }) : super(
         retry: null,
         name: r'earthquakeHistoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$earthquakeHistoryNotifierHash();

  @override
  String toString() {
    return r'earthquakeHistoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EarthquakeHistoryNotifier create() => EarthquakeHistoryNotifier();

  @override
  bool operator ==(Object other) {
    return other is EarthquakeHistoryNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$earthquakeHistoryNotifierHash() =>
    r'c15060df49a37b912c82eab77517be0f88e80b9c';

final class EarthquakeHistoryNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          EarthquakeHistoryNotifier,
          AsyncValue<EarthquakeHistoryNotifierState>,
          EarthquakeHistoryNotifierState,
          FutureOr<EarthquakeHistoryNotifierState>,
          EarthquakeHistoryParameter
        > {
  EarthquakeHistoryNotifierFamily._()
    : super(
        retry: null,
        name: r'earthquakeHistoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EarthquakeHistoryNotifierProvider call(
    EarthquakeHistoryParameter parameter,
  ) => EarthquakeHistoryNotifierProvider._(argument: parameter, from: this);

  @override
  String toString() => r'earthquakeHistoryProvider';
}

abstract class _$EarthquakeHistoryNotifier
    extends $AsyncNotifier<EarthquakeHistoryNotifierState> {
  late final _$args = ref.$arg as EarthquakeHistoryParameter;
  EarthquakeHistoryParameter get parameter => _$args;

  FutureOr<EarthquakeHistoryNotifierState> build(
    EarthquakeHistoryParameter parameter,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<EarthquakeHistoryNotifierState>,
              EarthquakeHistoryNotifierState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<EarthquakeHistoryNotifierState>,
                EarthquakeHistoryNotifierState
              >,
              AsyncValue<EarthquakeHistoryNotifierState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
