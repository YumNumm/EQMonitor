// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_activity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(earthquakeActivityRepository)
final earthquakeActivityRepositoryProvider =
    EarthquakeActivityRepositoryProvider._();

final class EarthquakeActivityRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<EarthquakeActivityRepository>,
          EarthquakeActivityRepository,
          FutureOr<EarthquakeActivityRepository>
        >
    with
        $FutureModifier<EarthquakeActivityRepository>,
        $FutureProvider<EarthquakeActivityRepository> {
  EarthquakeActivityRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'earthquakeActivityRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$earthquakeActivityRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<EarthquakeActivityRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EarthquakeActivityRepository> create(Ref ref) {
    return earthquakeActivityRepository(ref);
  }
}

String _$earthquakeActivityRepositoryHash() =>
    r'0e19080b4f35a6ec8cdd60788a430ff0d22844f3';

@ProviderFor(EarthquakeActivityProgress)
final earthquakeActivityProgressProvider = EarthquakeActivityProgressFamily._();

final class EarthquakeActivityProgressProvider
    extends $NotifierProvider<EarthquakeActivityProgress, int> {
  EarthquakeActivityProgressProvider._({
    required EarthquakeActivityProgressFamily super.from,
    required EarthquakeActivityQuery super.argument,
  }) : super(
         retry: null,
         name: r'earthquakeActivityProgressProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$earthquakeActivityProgressHash();

  @override
  String toString() {
    return r'earthquakeActivityProgressProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EarthquakeActivityProgress create() => EarthquakeActivityProgress();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is EarthquakeActivityProgressProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$earthquakeActivityProgressHash() =>
    r'700c27130d7caa36bec6013283508693cd87d4a4';

final class EarthquakeActivityProgressFamily extends $Family
    with
        $ClassFamilyOverride<
          EarthquakeActivityProgress,
          int,
          int,
          int,
          EarthquakeActivityQuery
        > {
  EarthquakeActivityProgressFamily._()
    : super(
        retry: null,
        name: r'earthquakeActivityProgressProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EarthquakeActivityProgressProvider call(EarthquakeActivityQuery query) =>
      EarthquakeActivityProgressProvider._(argument: query, from: this);

  @override
  String toString() => r'earthquakeActivityProgressProvider';
}

abstract class _$EarthquakeActivityProgress extends $Notifier<int> {
  late final _$args = ref.$arg as EarthquakeActivityQuery;
  EarthquakeActivityQuery get query => _$args;

  int build(EarthquakeActivityQuery query);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(EarthquakeActivity)
final earthquakeActivityProvider = EarthquakeActivityFamily._();

final class EarthquakeActivityProvider
    extends
        $AsyncNotifierProvider<EarthquakeActivity, EarthquakeActivityDataset> {
  EarthquakeActivityProvider._({
    required EarthquakeActivityFamily super.from,
    required EarthquakeActivityQuery super.argument,
  }) : super(
         retry: null,
         name: r'earthquakeActivityProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$earthquakeActivityHash();

  @override
  String toString() {
    return r'earthquakeActivityProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  EarthquakeActivity create() => EarthquakeActivity();

  @override
  bool operator ==(Object other) {
    return other is EarthquakeActivityProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$earthquakeActivityHash() =>
    r'e7153e9da201982b8d07915dbd08c9ddf619744f';

final class EarthquakeActivityFamily extends $Family
    with
        $ClassFamilyOverride<
          EarthquakeActivity,
          AsyncValue<EarthquakeActivityDataset>,
          EarthquakeActivityDataset,
          FutureOr<EarthquakeActivityDataset>,
          EarthquakeActivityQuery
        > {
  EarthquakeActivityFamily._()
    : super(
        retry: null,
        name: r'earthquakeActivityProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EarthquakeActivityProvider call(EarthquakeActivityQuery query) =>
      EarthquakeActivityProvider._(argument: query, from: this);

  @override
  String toString() => r'earthquakeActivityProvider';
}

abstract class _$EarthquakeActivity
    extends $AsyncNotifier<EarthquakeActivityDataset> {
  late final _$args = ref.$arg as EarthquakeActivityQuery;
  EarthquakeActivityQuery get query => _$args;

  FutureOr<EarthquakeActivityDataset> build(EarthquakeActivityQuery query);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<EarthquakeActivityDataset>,
              EarthquakeActivityDataset
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<EarthquakeActivityDataset>,
                EarthquakeActivityDataset
              >,
              AsyncValue<EarthquakeActivityDataset>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
