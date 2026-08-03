// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'hypocenter_catalog_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HypocenterManifestNotifier)
final hypocenterManifestProvider = HypocenterManifestNotifierProvider._();

final class HypocenterManifestNotifierProvider
    extends
        $AsyncNotifierProvider<HypocenterManifestNotifier, HypocenterManifest> {
  HypocenterManifestNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hypocenterManifestProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hypocenterManifestNotifierHash();

  @$internal
  @override
  HypocenterManifestNotifier create() => HypocenterManifestNotifier();
}

String _$hypocenterManifestNotifierHash() =>
    r'7e0bbd8e96046a16ae57cde7066080f94f3f287b';

abstract class _$HypocenterManifestNotifier
    extends $AsyncNotifier<HypocenterManifest> {
  FutureOr<HypocenterManifest> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<HypocenterManifest>, HypocenterManifest>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<HypocenterManifest>, HypocenterManifest>,
              AsyncValue<HypocenterManifest>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(hypocenterArchiveAvailable)
final hypocenterArchiveAvailableProvider = HypocenterArchiveAvailableFamily._();

final class HypocenterArchiveAvailableProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  HypocenterArchiveAvailableProvider._({
    required HypocenterArchiveAvailableFamily super.from,
    required HypocenterArchive super.argument,
  }) : super(
         retry: null,
         name: r'hypocenterArchiveAvailableProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$hypocenterArchiveAvailableHash();

  @override
  String toString() {
    return r'hypocenterArchiveAvailableProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    final argument = this.argument as HypocenterArchive;
    return hypocenterArchiveAvailable(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is HypocenterArchiveAvailableProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hypocenterArchiveAvailableHash() =>
    r'6f8d5edf15c21f5827f382144ad4dad5e4d387d5';

final class HypocenterArchiveAvailableFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<void>, HypocenterArchive> {
  HypocenterArchiveAvailableFamily._()
    : super(
        retry: null,
        name: r'hypocenterArchiveAvailableProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HypocenterArchiveAvailableProvider call(HypocenterArchive archive) =>
      HypocenterArchiveAvailableProvider._(argument: archive, from: this);

  @override
  String toString() => r'hypocenterArchiveAvailableProvider';
}

@ProviderFor(HypocenterAnalysis)
final hypocenterAnalysisProvider = HypocenterAnalysisFamily._();

final class HypocenterAnalysisProvider
    extends $AsyncNotifierProvider<HypocenterAnalysis, List<SeismicityEvent>> {
  HypocenterAnalysisProvider._({
    required HypocenterAnalysisFamily super.from,
    required HypocenterAnalysisRequest super.argument,
  }) : super(
         retry: null,
         name: r'hypocenterAnalysisProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$hypocenterAnalysisHash();

  @override
  String toString() {
    return r'hypocenterAnalysisProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  HypocenterAnalysis create() => HypocenterAnalysis();

  @override
  bool operator ==(Object other) {
    return other is HypocenterAnalysisProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hypocenterAnalysisHash() =>
    r'4ba87feb885ec7254213fac285fd4647667bd825';

final class HypocenterAnalysisFamily extends $Family
    with
        $ClassFamilyOverride<
          HypocenterAnalysis,
          AsyncValue<List<SeismicityEvent>>,
          List<SeismicityEvent>,
          FutureOr<List<SeismicityEvent>>,
          HypocenterAnalysisRequest
        > {
  HypocenterAnalysisFamily._()
    : super(
        retry: null,
        name: r'hypocenterAnalysisProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HypocenterAnalysisProvider call(HypocenterAnalysisRequest request) =>
      HypocenterAnalysisProvider._(argument: request, from: this);

  @override
  String toString() => r'hypocenterAnalysisProvider';
}

abstract class _$HypocenterAnalysis
    extends $AsyncNotifier<List<SeismicityEvent>> {
  late final _$args = ref.$arg as HypocenterAnalysisRequest;
  HypocenterAnalysisRequest get request => _$args;

  FutureOr<List<SeismicityEvent>> build(HypocenterAnalysisRequest request);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<SeismicityEvent>>, List<SeismicityEvent>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<SeismicityEvent>>,
                List<SeismicityEvent>
              >,
              AsyncValue<List<SeismicityEvent>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(HypocenterAnalysisProgressNotifier)
final hypocenterAnalysisProgressProvider =
    HypocenterAnalysisProgressNotifierFamily._();

final class HypocenterAnalysisProgressNotifierProvider
    extends
        $NotifierProvider<
          HypocenterAnalysisProgressNotifier,
          HypocenterAnalysisProgress
        > {
  HypocenterAnalysisProgressNotifierProvider._({
    required HypocenterAnalysisProgressNotifierFamily super.from,
    required HypocenterAnalysisRequest super.argument,
  }) : super(
         retry: null,
         name: r'hypocenterAnalysisProgressProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() =>
      _$hypocenterAnalysisProgressNotifierHash();

  @override
  String toString() {
    return r'hypocenterAnalysisProgressProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  HypocenterAnalysisProgressNotifier create() =>
      HypocenterAnalysisProgressNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HypocenterAnalysisProgress value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HypocenterAnalysisProgress>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is HypocenterAnalysisProgressNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$hypocenterAnalysisProgressNotifierHash() =>
    r'30367d8662f084139090be82efbc988f95e13ee3';

final class HypocenterAnalysisProgressNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          HypocenterAnalysisProgressNotifier,
          HypocenterAnalysisProgress,
          HypocenterAnalysisProgress,
          HypocenterAnalysisProgress,
          HypocenterAnalysisRequest
        > {
  HypocenterAnalysisProgressNotifierFamily._()
    : super(
        retry: null,
        name: r'hypocenterAnalysisProgressProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HypocenterAnalysisProgressNotifierProvider call(
    HypocenterAnalysisRequest request,
  ) => HypocenterAnalysisProgressNotifierProvider._(
    argument: request,
    from: this,
  );

  @override
  String toString() => r'hypocenterAnalysisProgressProvider';
}

abstract class _$HypocenterAnalysisProgressNotifier
    extends $Notifier<HypocenterAnalysisProgress> {
  late final _$args = ref.$arg as HypocenterAnalysisRequest;
  HypocenterAnalysisRequest get request => _$args;

  HypocenterAnalysisProgress build(HypocenterAnalysisRequest request);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<HypocenterAnalysisProgress, HypocenterAnalysisProgress>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                HypocenterAnalysisProgress,
                HypocenterAnalysisProgress
              >,
              HypocenterAnalysisProgress,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
