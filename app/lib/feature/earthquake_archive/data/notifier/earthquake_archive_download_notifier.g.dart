// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_archive_download_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EarthquakeArchiveDownloadNotifier)
final earthquakeArchiveDownloadProvider =
    EarthquakeArchiveDownloadNotifierProvider._();

final class EarthquakeArchiveDownloadNotifierProvider
    extends $NotifierProvider<EarthquakeArchiveDownloadNotifier, void> {
  EarthquakeArchiveDownloadNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'earthquakeArchiveDownloadProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$earthquakeArchiveDownloadNotifierHash();

  @$internal
  @override
  EarthquakeArchiveDownloadNotifier create() =>
      EarthquakeArchiveDownloadNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$earthquakeArchiveDownloadNotifierHash() =>
    r'cf1ae6b78e84d7ffbb3e3335bfd2a908ad6f8465';

abstract class _$EarthquakeArchiveDownloadNotifier extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
