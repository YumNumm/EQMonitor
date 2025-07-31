// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_history_early_details_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(earthquakeHistoryEarlyEvent)
const earthquakeHistoryEarlyEventProvider =
    EarthquakeHistoryEarlyEventFamily._();

final class EarthquakeHistoryEarlyEventProvider
    extends
        $FunctionalProvider<
          AsyncValue<EarthquakeEarlyEvent>,
          EarthquakeEarlyEvent,
          FutureOr<EarthquakeEarlyEvent>
        >
    with
        $FutureModifier<EarthquakeEarlyEvent>,
        $FutureProvider<EarthquakeEarlyEvent> {
  const EarthquakeHistoryEarlyEventProvider._({
    required EarthquakeHistoryEarlyEventFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'earthquakeHistoryEarlyEventProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$earthquakeHistoryEarlyEventHash();

  @override
  String toString() {
    return r'earthquakeHistoryEarlyEventProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<EarthquakeEarlyEvent> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EarthquakeEarlyEvent> create(Ref ref) {
    final argument = this.argument as String;
    return earthquakeHistoryEarlyEvent(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EarthquakeHistoryEarlyEventProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$earthquakeHistoryEarlyEventHash() =>
    r'45706d786f53b6d4c9396fbe2ac974d757ec1014';

final class EarthquakeHistoryEarlyEventFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<EarthquakeEarlyEvent>, String> {
  const EarthquakeHistoryEarlyEventFamily._()
    : super(
        retry: null,
        name: r'earthquakeHistoryEarlyEventProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EarthquakeHistoryEarlyEventProvider call(String id) =>
      EarthquakeHistoryEarlyEventProvider._(argument: id, from: this);

  @override
  String toString() => r'earthquakeHistoryEarlyEventProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
