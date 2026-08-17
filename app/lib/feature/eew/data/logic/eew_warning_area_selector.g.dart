// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_warning_area_selector.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eewWarningAreaSelector)
final eewWarningAreaSelectorProvider = EewWarningAreaSelectorProvider._();

final class EewWarningAreaSelectorProvider
    extends
        $FunctionalProvider<
          EewWarningAreaSelector,
          EewWarningAreaSelector,
          EewWarningAreaSelector
        >
    with $Provider<EewWarningAreaSelector> {
  EewWarningAreaSelectorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eewWarningAreaSelectorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eewWarningAreaSelectorHash();

  @$internal
  @override
  $ProviderElement<EewWarningAreaSelector> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EewWarningAreaSelector create(Ref ref) {
    return eewWarningAreaSelector(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EewWarningAreaSelector value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EewWarningAreaSelector>(value),
    );
  }
}

String _$eewWarningAreaSelectorHash() =>
    r'8a70b3461c6fad48b89dcf92b0a626a35a1563b1';
