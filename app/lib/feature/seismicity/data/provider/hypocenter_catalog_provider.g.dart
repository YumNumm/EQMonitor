// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'hypocenter_catalog_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(hypocenterManifest)
final hypocenterManifestProvider = HypocenterManifestProvider._();

final class HypocenterManifestProvider
    extends
        $FunctionalProvider<
          AsyncValue<HypocenterManifest>,
          HypocenterManifest,
          FutureOr<HypocenterManifest>
        >
    with
        $FutureModifier<HypocenterManifest>,
        $FutureProvider<HypocenterManifest> {
  HypocenterManifestProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hypocenterManifestProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hypocenterManifestHash();

  @$internal
  @override
  $FutureProviderElement<HypocenterManifest> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<HypocenterManifest> create(Ref ref) {
    return hypocenterManifest(ref);
  }
}

String _$hypocenterManifestHash() =>
    r'd09eef81883501130b6949034dda9c2ed10790a4';

@ProviderFor(hypocenterArchiveAvailable)
final hypocenterArchiveAvailableProvider = HypocenterArchiveAvailableFamily._();

final class HypocenterArchiveAvailableProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
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
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
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
    r'8d8ae922d458f8035d634a57108ff3f2a8b0779b';

final class HypocenterArchiveAvailableFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<bool>, HypocenterArchive> {
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

@ProviderFor(hypocenterAnalysis)
final hypocenterAnalysisProvider = HypocenterAnalysisFamily._();

final class HypocenterAnalysisProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SeismicityEvent>>,
          List<SeismicityEvent>,
          FutureOr<List<SeismicityEvent>>
        >
    with
        $FutureModifier<List<SeismicityEvent>>,
        $FutureProvider<List<SeismicityEvent>> {
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
  $FutureProviderElement<List<SeismicityEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SeismicityEvent>> create(Ref ref) {
    final argument = this.argument as HypocenterAnalysisRequest;
    return hypocenterAnalysis(ref, argument);
  }

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
    r'beaa2f125b9b612264f21f55756ed34a6254babd';

final class HypocenterAnalysisFamily extends $Family
    with
        $FunctionalFamilyOverride<
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
