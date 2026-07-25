// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_warning_overlay_effective_display_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eewWarningOverlayEffectiveDisplay)
final eewWarningOverlayEffectiveDisplayProvider =
    EewWarningOverlayEffectiveDisplayProvider._();

final class EewWarningOverlayEffectiveDisplayProvider
    extends
        $FunctionalProvider<
          EewWarningOverlayDisplayModel?,
          EewWarningOverlayDisplayModel?,
          EewWarningOverlayDisplayModel?
        >
    with $Provider<EewWarningOverlayDisplayModel?> {
  EewWarningOverlayEffectiveDisplayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eewWarningOverlayEffectiveDisplayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$eewWarningOverlayEffectiveDisplayHash();

  @$internal
  @override
  $ProviderElement<EewWarningOverlayDisplayModel?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EewWarningOverlayDisplayModel? create(Ref ref) {
    return eewWarningOverlayEffectiveDisplay(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EewWarningOverlayDisplayModel? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EewWarningOverlayDisplayModel?>(
        value,
      ),
    );
  }
}

String _$eewWarningOverlayEffectiveDisplayHash() =>
    r'490186e205c7ccbf9e47412855a9be7779537277';
