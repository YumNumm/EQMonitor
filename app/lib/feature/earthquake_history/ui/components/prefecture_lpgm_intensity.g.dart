// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'prefecture_lpgm_intensity.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_lpgmCalculator)
const _lpgmCalculatorProvider = _LpgmCalculatorFamily._();

final class _LpgmCalculatorProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<JmaLgIntensity, List<_MergedPrefectureIntensity>>>,
          FutureOr<Map<JmaLgIntensity, List<_MergedPrefectureIntensity>>>
        >
    with
        $FutureModifier<Map<JmaLgIntensity, List<_MergedPrefectureIntensity>>>,
        $FutureProvider<Map<JmaLgIntensity, List<_MergedPrefectureIntensity>>> {
  const _LpgmCalculatorProvider._({
    required _LpgmCalculatorFamily super.from,
    required _Arg super.argument,
  }) : super(
         retry: null,
         name: r'_lpgmCalculatorProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$lpgmCalculatorHash();

  @override
  String toString() {
    return r'_lpgmCalculatorProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Map<JmaLgIntensity, List<_MergedPrefectureIntensity>>>
  $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<JmaLgIntensity, List<_MergedPrefectureIntensity>>> create(
    Ref ref,
  ) {
    final argument = this.argument as _Arg;
    return _lpgmCalculator(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is _LpgmCalculatorProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$lpgmCalculatorHash() => r'6e4fb84f94c2bb397d7704498b6ece2284cd32f2';

final class _LpgmCalculatorFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Map<JmaLgIntensity, List<_MergedPrefectureIntensity>>>,
          _Arg
        > {
  const _LpgmCalculatorFamily._()
    : super(
        retry: null,
        name: r'_lpgmCalculatorProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _LpgmCalculatorProvider call(_Arg arg) =>
      _LpgmCalculatorProvider._(argument: arg, from: this);

  @override
  String toString() => r'_lpgmCalculatorProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
