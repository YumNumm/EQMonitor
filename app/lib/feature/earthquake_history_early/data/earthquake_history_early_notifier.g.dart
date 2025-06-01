// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'earthquake_history_early_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(EarthquakeHistoryEarlyNotifier)
const earthquakeHistoryEarlyNotifierProvider =
    EarthquakeHistoryEarlyNotifierFamily._();

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
         name: r'earthquakeHistoryEarlyNotifierProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$earthquakeHistoryEarlyNotifierHash();

  @override
  String toString() {
    return r'earthquakeHistoryEarlyNotifierProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EarthquakeHistoryEarlyNotifier create() => EarthquakeHistoryEarlyNotifier();

  @$internal
  @override
  $AsyncNotifierProviderElement<
    EarthquakeHistoryEarlyNotifier,
    EarthquakeHistoryEarlyNotifierState
  >
  $createElement($ProviderPointer pointer) =>
      $AsyncNotifierProviderElement(pointer);

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
    r'd7d873ac0cfdcd0d04abca854cdc6f380493b345';

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
        name: r'earthquakeHistoryEarlyNotifierProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EarthquakeHistoryEarlyNotifierProvider call(
    EarthquakeHistoryEarlyParameter parameter,
  ) =>
      EarthquakeHistoryEarlyNotifierProvider._(argument: parameter, from: this);

  @override
  String toString() => r'earthquakeHistoryEarlyNotifierProvider';
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
        this.ref as $Ref<AsyncValue<EarthquakeHistoryEarlyNotifierState>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<EarthquakeHistoryEarlyNotifierState>>,
              AsyncValue<EarthquakeHistoryEarlyNotifierState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
