// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'earthquake_history_details_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(EarthquakeHistoryDetailsNotifier)
const earthquakeHistoryDetailsNotifierProvider =
    EarthquakeHistoryDetailsNotifierFamily._();

final class EarthquakeHistoryDetailsNotifierProvider
    extends
        $AsyncNotifierProvider<
          EarthquakeHistoryDetailsNotifier,
          EarthquakeV1Extended
        > {
  const EarthquakeHistoryDetailsNotifierProvider._({
    required EarthquakeHistoryDetailsNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'earthquakeHistoryDetailsNotifierProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$earthquakeHistoryDetailsNotifierHash();

  @override
  String toString() {
    return r'earthquakeHistoryDetailsNotifierProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EarthquakeHistoryDetailsNotifier create() =>
      EarthquakeHistoryDetailsNotifier();

  @override
  bool operator ==(Object other) {
    return other is EarthquakeHistoryDetailsNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$earthquakeHistoryDetailsNotifierHash() =>
    r'8cdbb878aba7678a78260d89fc29555f5d9b54bc';

final class EarthquakeHistoryDetailsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          EarthquakeHistoryDetailsNotifier,
          AsyncValue<EarthquakeV1Extended>,
          EarthquakeV1Extended,
          FutureOr<EarthquakeV1Extended>,
          int
        > {
  const EarthquakeHistoryDetailsNotifierFamily._()
    : super(
        retry: null,
        name: r'earthquakeHistoryDetailsNotifierProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EarthquakeHistoryDetailsNotifierProvider call(int eventId) =>
      EarthquakeHistoryDetailsNotifierProvider._(argument: eventId, from: this);

  @override
  String toString() => r'earthquakeHistoryDetailsNotifierProvider';
}

abstract class _$EarthquakeHistoryDetailsNotifier
    extends $AsyncNotifier<EarthquakeV1Extended> {
  late final _$args = ref.$arg as int;
  int get eventId => _$args;

  FutureOr<EarthquakeV1Extended> build(int eventId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<AsyncValue<EarthquakeV1Extended>, EarthquakeV1Extended>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<EarthquakeV1Extended>,
                EarthquakeV1Extended
              >,
              AsyncValue<EarthquakeV1Extended>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
