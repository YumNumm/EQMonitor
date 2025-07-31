// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_history_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(EarthquakeHistoryNotifier)
const earthquakeHistoryNotifierProvider = EarthquakeHistoryNotifierFamily._();

final class EarthquakeHistoryNotifierProvider
    extends
        $AsyncNotifierProvider<
          EarthquakeHistoryNotifier,
          EarthquakeHistoryNotifierState
        > {
  const EarthquakeHistoryNotifierProvider._({
    required EarthquakeHistoryNotifierFamily super.from,
    required EarthquakeHistoryParameter super.argument,
  }) : super(
         retry: null,
         name: r'earthquakeHistoryNotifierProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$earthquakeHistoryNotifierHash();

  @override
  String toString() {
    return r'earthquakeHistoryNotifierProvider'
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
    r'e1bddc0afbe2c703f594c40acd784ddbd424c60f';

final class EarthquakeHistoryNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          EarthquakeHistoryNotifier,
          AsyncValue<EarthquakeHistoryNotifierState>,
          EarthquakeHistoryNotifierState,
          FutureOr<EarthquakeHistoryNotifierState>,
          EarthquakeHistoryParameter
        > {
  const EarthquakeHistoryNotifierFamily._()
    : super(
        retry: null,
        name: r'earthquakeHistoryNotifierProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EarthquakeHistoryNotifierProvider call(
    EarthquakeHistoryParameter parameter,
  ) => EarthquakeHistoryNotifierProvider._(argument: parameter, from: this);

  @override
  String toString() => r'earthquakeHistoryNotifierProvider';
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
    final created = build(_$args);
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
    element.handleValue(ref, created);
  }
}

@ProviderFor(earthquakeV1Extended)
const earthquakeV1ExtendedProvider = EarthquakeV1ExtendedFamily._();

final class EarthquakeV1ExtendedProvider
    extends
        $FunctionalProvider<
          AsyncValue<EarthquakeV1Extended>,
          EarthquakeV1Extended,
          FutureOr<EarthquakeV1Extended>
        >
    with
        $FutureModifier<EarthquakeV1Extended>,
        $FutureProvider<EarthquakeV1Extended> {
  const EarthquakeV1ExtendedProvider._({
    required EarthquakeV1ExtendedFamily super.from,
    required EarthquakeV1 super.argument,
  }) : super(
         retry: null,
         name: r'earthquakeV1ExtendedProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$earthquakeV1ExtendedHash();

  @override
  String toString() {
    return r'earthquakeV1ExtendedProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<EarthquakeV1Extended> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EarthquakeV1Extended> create(Ref ref) {
    final argument = this.argument as EarthquakeV1;
    return earthquakeV1Extended(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EarthquakeV1ExtendedProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$earthquakeV1ExtendedHash() =>
    r'19ec401d223bac3130f06c83f3d01bef8eaf68f8';

final class EarthquakeV1ExtendedFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<EarthquakeV1Extended>,
          EarthquakeV1
        > {
  const EarthquakeV1ExtendedFamily._()
    : super(
        retry: null,
        name: r'earthquakeV1ExtendedProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EarthquakeV1ExtendedProvider call(EarthquakeV1 data) =>
      EarthquakeV1ExtendedProvider._(argument: data, from: this);

  @override
  String toString() => r'earthquakeV1ExtendedProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
