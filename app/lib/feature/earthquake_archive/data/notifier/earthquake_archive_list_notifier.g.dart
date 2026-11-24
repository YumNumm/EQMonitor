// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_archive_list_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EarthquakeArchiveListNotifier)
final earthquakeArchiveListProvider = EarthquakeArchiveListNotifierProvider._();

final class EarthquakeArchiveListNotifierProvider
    extends
        $AsyncNotifierProvider<
          EarthquakeArchiveListNotifier,
          EarthquakeArchivePage
        > {
  EarthquakeArchiveListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'earthquakeArchiveListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$earthquakeArchiveListNotifierHash();

  @$internal
  @override
  EarthquakeArchiveListNotifier create() => EarthquakeArchiveListNotifier();
}

String _$earthquakeArchiveListNotifierHash() =>
    r'a20a63a5448607a8e20e7e3ebebe505fe135e1d3';

abstract class _$EarthquakeArchiveListNotifier
    extends $AsyncNotifier<EarthquakeArchivePage> {
  FutureOr<EarthquakeArchivePage> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<EarthquakeArchivePage>, EarthquakeArchivePage>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<EarthquakeArchivePage>,
                EarthquakeArchivePage
              >,
              AsyncValue<EarthquakeArchivePage>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
