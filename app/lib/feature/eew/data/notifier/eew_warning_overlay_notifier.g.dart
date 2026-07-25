// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eew_warning_overlay_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(EewWarningOverlayNotifier)
final eewWarningOverlayProvider = EewWarningOverlayNotifierProvider._();

final class EewWarningOverlayNotifierProvider
    extends
        $NotifierProvider<EewWarningOverlayNotifier, EewWarningOverlayState> {
  EewWarningOverlayNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eewWarningOverlayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eewWarningOverlayNotifierHash();

  @$internal
  @override
  EewWarningOverlayNotifier create() => EewWarningOverlayNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EewWarningOverlayState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EewWarningOverlayState>(value),
    );
  }
}

String _$eewWarningOverlayNotifierHash() =>
    r'137eeea0239a552ac2dc4519eaf1cd07c60ac907';

abstract class _$EewWarningOverlayNotifier
    extends $Notifier<EewWarningOverlayState> {
  EewWarningOverlayState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<EewWarningOverlayState, EewWarningOverlayState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EewWarningOverlayState, EewWarningOverlayState>,
              EewWarningOverlayState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
