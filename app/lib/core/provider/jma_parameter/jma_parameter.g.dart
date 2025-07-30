// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'jma_parameter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(JmaParameter)
const jmaParameterProvider = JmaParameterProvider._();

final class JmaParameterProvider
    extends $StreamNotifierProvider<JmaParameter, JmaParameterState> {
  const JmaParameterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'jmaParameterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$jmaParameterHash();

  @$internal
  @override
  JmaParameter create() => JmaParameter();
}

String _$jmaParameterHash() => r'27235c3f43d2ad4f6a6fbe97f8d741b8f125c2f6';

abstract class _$JmaParameter extends $StreamNotifier<JmaParameterState> {
  Stream<JmaParameterState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<JmaParameterState>, JmaParameterState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<JmaParameterState>, JmaParameterState>,
              AsyncValue<JmaParameterState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(EarthquakeParameterEtag)
const earthquakeParameterEtagProvider = EarthquakeParameterEtagProvider._();

final class EarthquakeParameterEtagProvider
    extends $NotifierProvider<EarthquakeParameterEtag, String?> {
  const EarthquakeParameterEtagProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'earthquakeParameterEtagProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$earthquakeParameterEtagHash();

  @$internal
  @override
  EarthquakeParameterEtag create() => EarthquakeParameterEtag();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$earthquakeParameterEtagHash() =>
    r'2351454514903ab08fe4100dc59680743b4ee26d';

abstract class _$EarthquakeParameterEtag extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
