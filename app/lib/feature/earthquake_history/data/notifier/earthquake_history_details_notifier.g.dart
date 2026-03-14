// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_history_details_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EarthquakeHistoryDetailsNotifier)
final earthquakeHistoryDetailsProvider =
    EarthquakeHistoryDetailsNotifierFamily._();

final class EarthquakeHistoryDetailsNotifierProvider
    extends
        $AsyncNotifierProvider<
          EarthquakeHistoryDetailsNotifier,
          EarthquakeDetailResponse
        > {
  EarthquakeHistoryDetailsNotifierProvider._({
    required EarthquakeHistoryDetailsNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'earthquakeHistoryDetailsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$earthquakeHistoryDetailsNotifierHash();

  @override
  String toString() {
    return r'earthquakeHistoryDetailsProvider'
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
    r'da7b66e40a3bf1f11f9c7ee8fa2c9dd386d58af5';

final class EarthquakeHistoryDetailsNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          EarthquakeHistoryDetailsNotifier,
          AsyncValue<EarthquakeDetailResponse>,
          EarthquakeDetailResponse,
          FutureOr<EarthquakeDetailResponse>,
          String
        > {
  EarthquakeHistoryDetailsNotifierFamily._()
    : super(
        retry: null,
        name: r'earthquakeHistoryDetailsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EarthquakeHistoryDetailsNotifierProvider call(String eventId) =>
      EarthquakeHistoryDetailsNotifierProvider._(argument: eventId, from: this);

  @override
  String toString() => r'earthquakeHistoryDetailsProvider';
}

abstract class _$EarthquakeHistoryDetailsNotifier
    extends $AsyncNotifier<EarthquakeDetailResponse> {
  late final _$args = ref.$arg as String;
  String get eventId => _$args;

  FutureOr<EarthquakeDetailResponse> build(String eventId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<EarthquakeDetailResponse>,
              EarthquakeDetailResponse
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<EarthquakeDetailResponse>,
                EarthquakeDetailResponse
              >,
              AsyncValue<EarthquakeDetailResponse>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
