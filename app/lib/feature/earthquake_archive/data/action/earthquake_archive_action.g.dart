// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_archive_action.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(earthquakeArchiveAction)
final earthquakeArchiveActionProvider = EarthquakeArchiveActionProvider._();

final class EarthquakeArchiveActionProvider
    extends
        $FunctionalProvider<
          EarthquakeArchiveAction,
          EarthquakeArchiveAction,
          EarthquakeArchiveAction
        >
    with $Provider<EarthquakeArchiveAction> {
  EarthquakeArchiveActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'earthquakeArchiveActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$earthquakeArchiveActionHash();

  @$internal
  @override
  $ProviderElement<EarthquakeArchiveAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EarthquakeArchiveAction create(Ref ref) {
    return earthquakeArchiveAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EarthquakeArchiveAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EarthquakeArchiveAction>(value),
    );
  }
}

String _$earthquakeArchiveActionHash() =>
    r'3458b1585c8e9ff2daf8bea995da6d55bcd5904a';
