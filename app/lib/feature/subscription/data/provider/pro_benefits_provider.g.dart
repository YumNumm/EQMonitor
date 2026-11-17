// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'pro_benefits_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// この端末で案内できる EQMonitor Pro の機能。
///
/// 揺れ検知の通知は、設定画面を表示できる端末にだけ案内する。

@ProviderFor(proBenefits)
final proBenefitsProvider = ProBenefitsProvider._();

/// この端末で案内できる EQMonitor Pro の機能。
///
/// 揺れ検知の通知は、設定画面を表示できる端末にだけ案内する。

final class ProBenefitsProvider
    extends
        $FunctionalProvider<
          List<ProBenefit>,
          List<ProBenefit>,
          List<ProBenefit>
        >
    with $Provider<List<ProBenefit>> {
  /// この端末で案内できる EQMonitor Pro の機能。
  ///
  /// 揺れ検知の通知は、設定画面を表示できる端末にだけ案内する。
  ProBenefitsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'proBenefitsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$proBenefitsHash();

  @$internal
  @override
  $ProviderElement<List<ProBenefit>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<ProBenefit> create(Ref ref) {
    return proBenefits(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ProBenefit> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ProBenefit>>(value),
    );
  }
}

String _$proBenefitsHash() => r'acad7ba4c5b6bf4c03026b63d40720899e5817f0';
