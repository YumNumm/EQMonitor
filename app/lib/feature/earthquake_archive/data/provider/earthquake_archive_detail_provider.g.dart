// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_archive_detail_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(earthquakeArchiveDetail)
final earthquakeArchiveDetailProvider = EarthquakeArchiveDetailFamily._();

final class EarthquakeArchiveDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<EarthquakeArchive>,
          EarthquakeArchive,
          FutureOr<EarthquakeArchive>
        >
    with
        $FutureModifier<EarthquakeArchive>,
        $FutureProvider<EarthquakeArchive> {
  EarthquakeArchiveDetailProvider._({
    required EarthquakeArchiveDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'earthquakeArchiveDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$earthquakeArchiveDetailHash();

  @override
  String toString() {
    return r'earthquakeArchiveDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<EarthquakeArchive> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EarthquakeArchive> create(Ref ref) {
    final argument = this.argument as String;
    return earthquakeArchiveDetail(ref, eventId: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EarthquakeArchiveDetailProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$earthquakeArchiveDetailHash() =>
    r'48972390899d36a030c1967e78d95b0ef2be7ab0';

final class EarthquakeArchiveDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<EarthquakeArchive>, String> {
  EarthquakeArchiveDetailFamily._()
    : super(
        retry: null,
        name: r'earthquakeArchiveDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EarthquakeArchiveDetailProvider call({required String eventId}) =>
      EarthquakeArchiveDetailProvider._(argument: eventId, from: this);

  @override
  String toString() => r'earthquakeArchiveDetailProvider';
}
