// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_warning_overlay_display_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eewWarningOverlayDisplay)
final eewWarningOverlayDisplayProvider = EewWarningOverlayDisplayProvider._();

final class EewWarningOverlayDisplayProvider
    extends
        $FunctionalProvider<
          EewWarningOverlayDisplayModel?,
          EewWarningOverlayDisplayModel?,
          EewWarningOverlayDisplayModel?
        >
    with $Provider<EewWarningOverlayDisplayModel?> {
  EewWarningOverlayDisplayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eewWarningOverlayDisplayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eewWarningOverlayDisplayHash();

  @$internal
  @override
  $ProviderElement<EewWarningOverlayDisplayModel?> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EewWarningOverlayDisplayModel? create(Ref ref) {
    return eewWarningOverlayDisplay(ref);
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

String _$eewWarningOverlayDisplayHash() =>
    r'4d36d5f249e7b462447e724d3dc6ea0eae8405ff';
