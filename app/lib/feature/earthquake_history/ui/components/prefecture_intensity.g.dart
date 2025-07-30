// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'prefecture_intensity.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(_calculator)
const _calculatorProvider = _CalculatorFamily._();

final class _CalculatorProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<JmaIntensity, List<_MergedRegionIntensity>>>,
          Map<JmaIntensity, List<_MergedRegionIntensity>>,
          FutureOr<Map<JmaIntensity, List<_MergedRegionIntensity>>>
        >
    with
        $FutureModifier<Map<JmaIntensity, List<_MergedRegionIntensity>>>,
        $FutureProvider<Map<JmaIntensity, List<_MergedRegionIntensity>>> {
  const _CalculatorProvider._({
    required _CalculatorFamily super.from,
    required _Arg super.argument,
  }) : super(
         retry: null,
         name: r'_calculatorProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$calculatorHash();

  @override
  String toString() {
    return r'_calculatorProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Map<JmaIntensity, List<_MergedRegionIntensity>>>
  $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<JmaIntensity, List<_MergedRegionIntensity>>> create(Ref ref) {
    final argument = this.argument as _Arg;
    return _calculator(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is _CalculatorProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$calculatorHash() => r'04b6761f20dbdfc38319c53807b92dff5751d6b0';

final class _CalculatorFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Map<JmaIntensity, List<_MergedRegionIntensity>>>,
          _Arg
        > {
  const _CalculatorFamily._()
    : super(
        retry: null,
        name: r'_calculatorProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  _CalculatorProvider call(_Arg arg) =>
      _CalculatorProvider._(argument: arg, from: this);

  @override
  String toString() => r'_calculatorProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
